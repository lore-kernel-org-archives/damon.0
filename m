Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.0
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468361;
	b=CS8igmQuKyR+0dnoV2nX8rja7yD8EIaknGz+Re12WzF3jMI2V64UGGPX9q975FkGftim
	 BqkhqTnNhh/0aIi8Ik3ilxqR3/rXlvG0706K6vW5vEccXTJ2JE7vUbLO4fYT7OQ4Ah48x
	 jBhpbYAdEbFczLnMtphDLGkDgSUPARzfFJm7EYbLTDW9QB5Oux/l4x4Hh8fhbzuml6ZUi
	 gle2Q4ZREyiPcBb9ydiFmNqcg62gEcutfIOlUaedeHi0PgAa08e9fLuRUVtQYjyX//ffI
	 3PouwQ4sP5fPt/c4Tw1BptNtCYiQMe6x5lEbfMKyiDqi4TNKE+HxK6+OuYkKW5YUp2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Date:Message-ID:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=5RS4/TCOhSiJb1fSn9tcNQ8qqueFM9qglyQ2e/KfPJY=;
	b=QGt/WJqKiCN2MjomyrUbp8MD5+3rGwjlZL5cxmdEOLW/+mBNNQuB16pXor03MqvUl+3M
	 +1pL6RAAg3MtJYrLulhBRVQ1Frk+YAiGzjyJZ3rbS2q2B9djLFIiJXgMtdUjpvyH6jfyM
	 qguyvkkAX2IVtXaejjGeDoGBrcqhyShpQP4I29BrfHuosJ3ME81AmvhIMVIklhu2lKL07
	 tQ8/IwdrRmirFxwgPX7Y2B5zWDB12Z2WUVi4MRy2VBobMeuLTxx8m+dLAqvafQa+l2lxZ
	 YT4TkUp5DQ4O1jU7lqBEK/oxjSGar7rRgOKxhT3RAF0p5hyYuKeKsPXgB+9k8TQkedA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z6fcIhc1;
	arc=none smtp.remote-ip=74.125.229.0
Received: from mail-dy2-f0.google.com (mail-dy2-f0.google.com [74.125.229.0])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89E606A31F
	for <damon@lists.linux.dev>; Sat, 31 Oct 2026 17:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E89E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z6fcIhc1
Received: by mail-dy2-f0.google.com with SMTP id 5a478bee46e88-3117f9b9e64so147293eec.0
        for <damon@lists.linux.dev>; Sat, 31 Oct 2026 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793468355; x=1794073155; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5RS4/TCOhSiJb1fSn9tcNQ8qqueFM9qglyQ2e/KfPJY=;
        b=z6fcIhc1iAcyDsV7uPuN5EDT00DWiCSLq+IPG6I4+dFufTIyoDHRBoRrVi2Z6h0Eb6
         um06QovGoX6clOJSKkptqPhvTzApz5/Ok+t6bA2uYEYR8rxZJkUsh01ll9qiXOLe5ckE
         aBRwEizql8F6srNXk/PAHlqW4xOWjSfMFgEaWeIEfBZJjx90/RV/G37MSwg3ihJ5sqMn
         Zd+LYjWsfHFtKzmzPu5PLCjWb5tAvi4wJd00hidks3VmsZaGEaSsVyivJxL++47r6x68
         GxWjuEN6nxK4DlxbnK35LtG4l/JpEdq2f91FeumwVs0UtPjBTjnFj4Ir+IMWAYrPAyKX
         d8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468355; x=1794073155;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RS4/TCOhSiJb1fSn9tcNQ8qqueFM9qglyQ2e/KfPJY=;
        b=iU95tpf967kZFBaT3+JLXMNo8YUS2RryaFN9HAn0djUZwqJU9E4tOBC36kx4/K+/ym
         ix19DRLZFoZP4bIETtbCdAHcMIinGcIPPuj/5sOdruCy/Og0YxvTM0Z70MDC1UaVn5Ca
         Q7fSTEA2EgIE+cUYppdMDMdfKj/T8Ilua34LQ3m0HEkDAUTMY6wFJo53XHvWv01Wsa8H
         wEaJ6GJcqdZ2rVKWzqq/3t0MMNesJeQalKL3jtJ2gd9htzcCQAymdfzT4yuOli3JBOo6
         qIKQ2QTnmxIlCcB67j5xgp3xldIujxfCe+vPD6J4QuZneqr6mHK/p77saRHR4jPDWZSL
         cqbw==
X-Forwarded-Encrypted: i=1; AKwUvByZqk1Wb63WOszWogbfauZn54+jjWP6kKub8lCt8iKZmwbZHvlhzZ/oTa+cmZ0tsOC4af87fg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLVaEh2Wxn+oD54CRKcH9OAyAz7fgSMHSXf+MCXS4UqcP+K5KN0
	t1a49niErqCzPNx00xhSFcLnE8TSbqoKAiWE8SPq8uo0iZcIwfl9O9Nt
X-Gm-Gg: AYBFou1OtLsr3hyTGXXB/1f25Xnif94nJlc+UUOZO3Sb5ssKL0WIQnW3rGSXIo3V8Zk
	XA/IJNoNxKJWzEI0Fz3qP+87mOqgaiOc7esgpUgP/9vT8MPH5yomWmc1ulGPtaIl4bIUk854Ciu
	BFpWL696F47xW/ZKgi5keeiWWemZ8jwW6W4wGF7R/DafG9Nt+y84nQ+NhW8HfvA0ueTQNGn7WTD
	RDirvP76fqM9BHiKapgPP3WQrYb0oDN4Xignt7XzOsSAF+fZAGC493g4eWuPqc1LejNPR5dJfAA
	JInHfSHaWfJ61qdt0aYw19AyuSQizI2JW9wECYL53QAk8kIvbRA8fTI1Zo0IOAoO5Efo533UPaY
	KKjuQpsW1LDCkDuTnJ5u3C81W1Qk07QxGsjvYSAHk8i31RPA8giVOgSLqBUcL/oowrVdsTcWaRi
	SImd8FvGcNM9MOQ0UFjOkI3pnX4eNm8zoXIa+CPMSUuW1q4Bg6LJChfUIGwc43GFu7QnCr3weWh
	Gl14B3z+bzWKRzPWdyeVZ8n3D4OoH7GDeVArzs9Wd5Lte45ifw4ET+DD+OsD4Eg7PiERruPtpnk
	YT05ADeNogXMCWyKxwV8RUEQrr3FZmqdu8+rPRWE+LPulV2+ZBHeQQB6E9jAa6K8tz0y6iPprOB
	z8zpuE/vu+4Fjg6/WJP7tRYP4nmFbclJU5w==
X-Received: by 2002:a05:7022:258f:b0:19e:78fe:9d67 with SMTP id a92af1059eb24-1ac5a680801mr9985603c88.9.1793468354679;
        Sat, 31 Oct 2026 10:39:14 -0700 (PDT)
Received: from [192.168.50.20] (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac194b5437sm19811655c88.13.2026.10.31.10.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:39:14 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org
Date: Sun, 01 Nov 2026 03:34:41 +1100
Message-ID: <179346448183.4.15545164251841296990@gmail.com>
Subject:
 Re: [RFC PATCH] selftests/damon/sysfs_memcg_path_leak: define ksft_skip
In-Reply-To: <20261031153858.84302-1-sj@kernel.org>
References: <179342136087.2.16978105493403840270@gmail.com>
 <20261031153858.84302-1-sj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi SJ,

On Sat, 31 Oct 2026 08:38:58 -0700 SJ Park wrote:

> Thank you for reviewing, Aveline.

Oh, looks like I forgot that. Thanks for the reminder.

That also gives me an idea: maybe I could build a modular tool to help
write emails. Building on b4 might be a good starting point.

Tested the non-root skip path on x86-64 Linux with Bash 5.3.20:
the exit status changed from 0 to 4.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
