Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795353786;
	b=VVCnHgrnQT9nod+vKXtCvbmNT7bDhIHrIqiuDEoucPxF0c7Ifj2dAQ4BYA5tKd9FTUn4
	 AjEzCq/amLa5ZJWMNkGOCSPYhKM2NOwYH7mcxET9mLJTHSIiHIIWgb1HiQ2euuNGJaC4I
	 7JoPX9hwOHq/IDVZ/JN/tTb97UsXpEH2vkIXppfzM9AFe/VBGMtIUdvxEcWuihn38voeG
	 ZFXIeWk2Uslxliypk+OsQTP6w9IYeC/eW1W0mbPojoUL5Q+BLxqBsIhadzfqkjUAE5EB5
	 hp72/UZD4AUuaIMaxk0bYLQNb/dX4/U8gQf1Fza7bISSGx/78ZC1iEuu/MweYrsPdow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795353786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qbyPzks2HSto2dy3vHKwWbemcbPgmqWR617Ql6FivbQ=;
	b=abkxRvZbK27wNUyZZlVyMaHH5vZaQH3KAQy2XX3VJTUmviFngKJkJWc9XVYCqGg3LaPR
	 6EWn4nfOtWIrbcHuFJvsfkL1IN9rKnyfVMJjFLbVJ2fvHNFCa64S3YbKX1mcgjqYB6eZm
	 UoiTs6Wsss/2nG0XE+N6zRMT6cI9UO3lzuhs9tW6ermacXnzwX/3tAL2UYWQmPOsHRFnW
	 ttSaUOOfm6i3qGL451rvfGJDS4Oh+izGmA70LeNrEifIRlJ87HA4Np7VTcascEKYzWN84
	 KwWUh/FZ94HObGCRbwpvtTUGujCBwBWvQgAWgqMPyeFzy8CFFdI6QPqsFc0yB1y+gkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mQK4JFJc;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC65B606A320
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 13:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC65B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mQK4JFJc
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3869f03af6aso1313726eec.1
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 05:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795353785; x=1795958585; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qbyPzks2HSto2dy3vHKwWbemcbPgmqWR617Ql6FivbQ=;
        b=mQK4JFJcc+P9XWwiqGiV3363SoW9ponFi5iZiiYZKl4ySlGhTufdTITPKcSOT01Bii
         EEWP3te/urt7VG/xp5/guQvix0/FgHCPYs4oWs1wmXqLRPE/cyMXe9eC1BblgVfvA5oE
         /V92AqGwACqUaBiDXLYwA5ikiOsz4JNiW1u/0kWLPItqmCbEW68ixhHb95QeNdfFifpX
         NZUux8XH/rDVtQfyhrzWmP9O9CaycQcPmwt/QJKCppNtmSG59Qx/cMkV0xDDCEmPUynd
         Qd9sWRowqGum7SH2rZXIChY+Ow3lvlf+knvSgwy/IiNi19thCAH76dGr7qUCfHbpPyub
         VR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795353785; x=1795958585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qbyPzks2HSto2dy3vHKwWbemcbPgmqWR617Ql6FivbQ=;
        b=hiyYOwOGdDweuldq+/YNVVB2p2ylsMAmzM/QTOpsOggcTlPE1XNQMYv4OC0Kt66Pwa
         etV6pMsvwfCDYn9d0/ntWwEgxshfiMXDe6Im4jR2NMzI1IrBsr08Ss54hbRrROnQnHhQ
         5hlASTu30mgi2y4hQ28v16HjZcyYurFfKwAKgr9ob95BDbGy+1e+Cy3mHJvP6yo8w0hY
         +j5sTYua89NLtGyJI3HNpHqZ6SzrfjzIib4grqurLLZ8JVl5FU83J0EBJkDdPcU8uIQQ
         IV6pzdzXjLGYT9ZQX5h4dmMrjK7rkuURS5dZtArOENwo/Wr+uQnImX63s4ziRJBniqNa
         GbkA==
X-Forwarded-Encrypted: i=1; AL+hErGmqXEeIQ4bWQZRo6x4rLkTPMoXnLoIvlLmzHuIXDVQsQ3eUFJC/8gRwr3AaozDm8LLvu+vWw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8EywhrE/AAtTylocp0nJpyhrn+m9gXIxlDmSzEQaw+0P5wRwqU
	2CtcDy+PnUiVtdyNKAxcajokCAiCceiE4J7RYfjkslrIdotpJZkNHdtDTYBR9lYEVP0=
X-Gm-Gg: AZFdTZd4RvDALDPG1wp1l0jYeaC6qpRWhRhA+i5U5UmUDiLx9VrWAvP4VAQirBizWfR
	2r6jTiFpMYIpZ0v24J+ro5XCxUN8iVCfxEIUbfzc95fOuZuMJhIOoWYFVr5AGCa3MmKZs3IajJS
	c5+ySWbPb5geeDd4colwTsSLKqD42GYU8JOvB81MykjWmtCT8pinsBRXpS88pFvYlarqhUUE6Q1
	jm4dJlO6XqdmlTouGIZZfE3PkdNxxPx+hIFo+FR+yIU67uGjGBf2SjO18+Na6J/4Nvoti2o082r
	zqsjHYC4wnuGQxYUAm6H8m6gxy9wPAqIMEUPZIKrgPRkbPOc3FqaYnW5hMJNGmmzHzfZNZp6YDk
	mFPyElqQr5m/53i1JicrwKA2wlGyoJZjZuSaTobcK+j2OxZuk1ERFe0Kt6gB5q/HDAoAHJjSWJM
	eOFfwDR5hWQsNZQDfDef+qRq5PtrEnnFUd3+6m5ynuK31pBhTUtqWcxIbhnpvFM5sPSQ7fw2qGb
	n82nd/1XGcpr4lCX5jzjmjmc8ZypQg8Av1Dvuj2+92JMFT276XwMtfWi896+uYwpb/RV3Vpae5N
	8BRrhI1bujW3LIFPoB3qYU8vK9cBGbJ70GOxj7p6Q6RCs5kPVZ3Yc+hiCyIvM0hNfRkJ
X-Received: by 2002:a05:693c:25cc:b0:369:f17d:efb with SMTP id 5a478bee46e88-384b3e77699mr14832756eec.10.1795353784860;
        Sun, 22 Nov 2026 05:23:04 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm26140224eec.23.2026.11.22.05.23.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 05:23:04 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 01/27] mm/damon/api: introduce struct damon_report
Date: Sun, 22 Nov 2026 21:22:18 +0800
Message-ID: <20261122132241.73734-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-2-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-2-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 12:59:45 -0800 SJ Park <sj@kernel.org> wrote:

> Define a struct for data attribute report.  The struct provides public
> fields for the type and the memory address range.  The type field
> represents the type of the report itself.  The address range is for the
> memory of the reporting data.  Data attribute producers can format their
> report using those fields.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
