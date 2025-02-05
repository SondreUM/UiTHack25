import React, { useState, useEffect, useRef } from 'react';

const MorseBinaryVisualizer = () => {
    const containerRef = useRef<HTMLDivElement>(null);
    const [isFullscreen, setIsFullscreen] = useState(false);
    const originalText = "UITHACK25 15 M0R53 57111 U53D";
    const ANIMATION_SPEED = 3;

    const UNIT = 40;
    const DOT_HEIGHT = 5;
    const DOT_WIDTH = UNIT;
    const DASH_WIDTH = UNIT * 3;
    const LETTER_SPACE = UNIT * 3;
    const WORD_SPACE = UNIT * 5;

    const morseCode: { [key: string]: string } = {
        'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.', 'F': '..-.', 'G': '--.',
        'H': '....', 'I': '..', 'J': '.---', 'K': '-.-', 'L': '.-..', 'M': '--', 'N': '-.',
        'O': '---', 'P': '.--.', 'Q': '--.-', 'R': '.-.', 'S': '...', 'T': '-', 'U': '..-',
        'V': '...-', 'W': '.--', 'X': '-..-', 'Y': '-.--', 'Z': '--..', '0': '-----',
        '1': '.----', '2': '..---', '3': '...--', '4': '....-', '5': '.....', '6': '-....',
        '7': '--...', '8': '---..', '9': '----.', ' ': ' '
    };

    const toggleFullscreen = () => {
        const container = containerRef.current;
        if (!container) return;

        if (!document.fullscreenElement) {
            if (container.requestFullscreen) {
                container.requestFullscreen();
            } else if ((container as any).webkitRequestFullscreen) {
                (container as any).webkitRequestFullscreen();
            } else if ((container as any).mozRequestFullScreen) {
                (container as any).mozRequestFullScreen();
            } else if ((container as any).msRequestFullscreen) {
                (container as any).msRequestFullscreen();
            }
            setIsFullscreen(true);
        } else {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            } else if ((document as any).webkitExitFullscreen) {
                (document as any).webkitExitFullscreen();
            } else if ((document as any).mozCancelFullScreen) {
                (document as any).mozCancelFullScreen();
            } else if ((document as any).msExitFullscreen) {
                (document as any).msExitFullscreen();
            }
            setIsFullscreen(false);
        }
    };

    const generateRandomChar = () => {
        const chars = 'abcdefghijklmnopqrstuvwxyz';
        return chars[Math.floor(Math.random() * chars.length)];
    };

    const generatePaddedText = () => {
        let padded = '';
        // Add random chars at the beginning, to make sure the start of the flag is visible
        for (let i = 0; i < 5; i++) {
            padded += generateRandomChar();
        }
        for (let i = 0; i < originalText.length; i++) {
            padded += originalText[i];
            // 60% chance to add random char
            if (Math.random() < 0.6) {
                padded += generateRandomChar();
            }
        }
        for (let i = 0; i < 5; i++) {
            padded += generateRandomChar();
        }
        return padded;
    };

    const generateMorsePoints = (text: string) => {
        const points = [];
        let x = 0;

        for (const char of text.toUpperCase()) {
            if (char === ' ') {
                x += WORD_SPACE;
                continue;
            }

            const morse = morseCode[char as keyof typeof morseCode] || '';
            for (const symbol of morse) {
                if (symbol === '.') {
                    points.push({ x, width: DOT_WIDTH, type: 'dot' });
                    x += DOT_WIDTH + UNIT;
                } else if (symbol === '-') {
                    points.push({ x, width: DASH_WIDTH, type: 'dash' });
                    x += DASH_WIDTH + UNIT;
                }
            }
            x += LETTER_SPACE;
        }
        return { points, totalWidth: x };
    };

    const generateBinaryPath = (text: string) => {
        let path = '';
        let x = 0;

        for (let i = 0; i < text.length; i++) {
            const char = text[i];
            const isOriginal = char === char.toUpperCase();
            let charWidth = 0;
            if (char == ' ') {
                charWidth = WORD_SPACE;
            } else {
                const morse = morseCode[char.toUpperCase()];
                charWidth = LETTER_SPACE;
                for (const symbol of morse) {
                    charWidth += (symbol == '.' ? DOT_WIDTH : DASH_WIDTH) + UNIT;
                }
            }

            if (isOriginal) {
                path += `${x === 0 ? 'M' : 'L'} ${x},120 L ${x + charWidth},120 `;
            } else {
                path += `${x === 0 ? 'M' : 'L'} ${x},180 L ${x + charWidth},180 `;
            }
            x += charWidth;
        }
        return { path, totalWidth: x };
    };

    const [offset, setOffset] = useState(0);
    const [paddedText, setPaddedText] = useState(generatePaddedText());
    const { points: morsePoints, totalWidth } = generateMorsePoints(paddedText);
    const { path: binaryPath } = generateBinaryPath(paddedText);

    useEffect(() => {
        const animate = () => {
            setOffset(prev => {
                if (prev + ANIMATION_SPEED >= totalWidth) {
                    setPaddedText(generatePaddedText());
                    return 0;
                }
                return prev + ANIMATION_SPEED;
            });
        };

        const interval = setInterval(animate, 20);
        return () => clearInterval(interval);
    }, [totalWidth]);

    useEffect(() => {
        const handleFullscreenChange = () => {
            setIsFullscreen(!!document.fullscreenElement);
        };

        document.addEventListener('fullscreenchange', handleFullscreenChange);
        return () => document.removeEventListener('fullscreenchange', handleFullscreenChange);
    }, []);

    return (
        <div ref={containerRef} className="relative w-full max-w-4xl mx-auto p-4 bg-white">
            <button
                onClick={toggleFullscreen}
                className="absolute top-2 right-2 p-2 bg-blue-500 text-white rounded hover:bg-blue-600 z-10"
            >
                {isFullscreen ? 'Exit Fullscreen' : 'Fullscreen'}
            </button>
            <svg viewBox="0 0 800 200" className="w-full h-full">
                <g transform={`translate(${-offset}, 0)`}>
                    {morsePoints.map((point, i) => (
                        <rect
                            key={`morse-${i}`}
                            x={point.x}
                            y={30}
                            width={point.width}
                            height={DOT_HEIGHT}
                            fill="#2563eb"
                        />
                    ))}
                </g>
                <g transform={`translate(${-offset}, 0)`}>
                    <path
                        d={binaryPath}
                        stroke="#B80F0A"
                        strokeWidth="5"
                        fill="none"
                    />
                </g>
            </svg>
        </div>
    );
};

export default MorseBinaryVisualizer;