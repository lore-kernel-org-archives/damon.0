Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435316;
	b=Io8UHbTlM1ArmtPJ0nET6wqufNy5If+nzcU4QLwprUBvQLKggTXZTCwUM6u+GSueZGKm
	 TYy5P/zRVyGNrfUdt+JdQVu8fuqPw/8EmV3aJS/205ofDFCiAhgz8hU20tPPDIv8QZ4+5
	 ADhUD7EDCNzY1Dk/TZMWIi+LqE7iHVJoGwE5TyfbRyBDrYfwUSvvF3NjaNIRcsajjUheD
	 S0/g2jvzxHLDMAXr0YVCmWinLussZVf0fMsrZ3RIgdNqen0XDtf7bm4Pi23KGMrIJ9aQI
	 yhgC9sI5KN7zLUbBRJAbnCMrE38REOMSU11/2g6xA83En2ro7GorlGEw6LoongSZXVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=e00YkeKRrjU+Nmoj9deWhfLwl2lr1/3aXWQO3K02B7A=;
	b=Q84+A9AgBw4XKQA72VB54bWZBnmCdnszlRp1v9XzACRcXHYOi9tOE2JIA7wt16bgYxQh
	 ndC/I0yTaUM5/tAkDr9j2fPsqh46zvo2yUHVZXLY4JJHUL2RJCEged9GCYaN8g55hPrNU
	 J4Wa6ACUZNYVun2a215u4S1Cb6U9gaqQhhQytoCrQ4iJQEifolIrhsE/NkA1G/0J4rNbJ
	 pmQbYqxghqM7Jw+pXSk/f+qE4pO7nvHMQXyiYFOIHp20iuJhOlNqoc3AmYd24rjFXjSdN
	 hgaBfhiUljjzJkEscSvQ8wf3t37tjGRsCbq8CkdRYGBVj+Ai6nJ29gDKzXtnVNgEqeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWpYOwSX;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9718606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 12:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9718606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWpYOwSX
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a2761c69fbso1852503c88.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 04:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435315; x=1796040115; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e00YkeKRrjU+Nmoj9deWhfLwl2lr1/3aXWQO3K02B7A=;
        b=VWpYOwSXolhyxF/hjrPx1ylmeiOWbJFln4EI8FjZUQKT+sNTAFDO6T5SENvFHkhyVl
         jTGI2MC6e/6DKqpNZycRSDBSbtrKU3QewRWZjqaD41AhbTe3gW/0o30TozkZMT+BwUGu
         7zGGuO8RAd4XPLoWxzZ+E10A5SFOkLSescxyxsKCs0A1GKW957RBO7fkeWbpBcCY/BDp
         HONBzJqF/cLHAmtsODdPQBJ5coQ3CZoCxlD7UE2CKcNtXdSz/fJPjxuQwhLyKlfCkuGr
         Jxw7+vYqt9jUWVDOtONoOi7OKwW/LTU7smWAaWGz/oKggj7J6XcSO3q9bUbixzv24S+W
         3fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435315; x=1796040115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e00YkeKRrjU+Nmoj9deWhfLwl2lr1/3aXWQO3K02B7A=;
        b=xPIhARbKTRSka/e1q1yLqAfCo8wQTpSf1fua7rTYiM4n3zV4KyhDnE89QDPC838O3y
         zjJiqfzYCGFDx82RzvoBGveb9pfQlNn3qtOnQaLy21mi48VmYiT6aNTEOv7KNGXZme9y
         sy32R4XVdDGZFJESCRtOMzbCzySlU+Xce6KnTbQqc8C6Lt86zSTShysTJwM+HQFhWr7e
         yjvuEaDKGryHs1kgbTHuZ7gn8pLg70ohGqRzsx2JNT1Xfo1wXoBQHXqHMaKJlR3+51Eu
         r6xqhWRGVG6/VNJhjZvsQ3o/l8EAGWvITjHBHBKRm3NPAcKs7OS6XkslhKtg7t87VpTe
         11Fw==
X-Forwarded-Encrypted: i=1; AL+hErHFD3cFa+bKNYNLqTtdj5onZMpJjzK98lILh5GDaC+sLIxT1r6sJ7IjgSd3ijyEH+BjLFZwEQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+qwfppnTBzEjQlw/FdrmISSbE6fwJ10wn0V1mPenpPFwuLJNAw
	ySp+qTf6rE0v6uCApyVn3RDn0CxaTh+vkf9+zBk5ScntuD1N/CqExGCD
X-Gm-Gg: AZFdTZePI96W+X31SWm+0wNMui8MLOCnaILQ1C5zTp3R2IonpWlOKDF1kmpqtC6qm6S
	p/c6d7hWE1ivZmv9v+LAJ3wPnRA+2EVwk+xrm3pB23y44jd+RVqeIRSSceNX60bFceGnlukVhwI
	pm6hoZzap7t811uL3hOZYbtdm269NOsVEg6eRe49EgXa6+PrWmigICuwyr0F9bBydu5g0MR5e/B
	wuVQM3WEO/DSdwejjONFV55Ruv6BltZ6ckaw7tAO8uomySw4RqeON0muvwPuUND3EPQJ3dxb0QD
	v3jCqUhKDbRpbYoDv1wisIlGF+F0Is1Qiyvxb+PjjxG+TsQbKx7sQcpr3pu7OOF3UJE7y8JFSEL
	EOGN8HuBdLmDiMsPZLV/4aMiA++KEflDoJ03Ihf/qRp2U8CGNZv3rbR/XpwU6zIJ9lVv2h/GOY4
	meSl1N4m9Ab9o5g619h07IVLZOW/i125ecc0jhKoW08hPlq+aLILp02QZ6X8BNSWUN7IJhowIas
	h7cAmQRDNvYXEfRC43H3YW+a7imZUNNs1UqRFpMApLxUO7iShq7EwXoFCBRw36haIuj/qEwzaPD
	UOsgFygC7gdA508GzOjLFNLISEg2rl+JWQ1y40O8xTnRPZvsWKqDr3rTWA4p42/XNWYhTuSonLk
	sFgcYwojWdcNyyg==
X-Received: by 2002:a05:7300:8188:b0:382:61d0:f375 with SMTP id 5a478bee46e88-3856e63b050mr17936494eec.7.1795435314904;
        Mon, 23 Nov 2026 04:01:54 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm45141438eec.5.2026.11.23.04.01.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 04:01:54 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 18/27] Docs/admin-guide/mm/damon/usage: update for REPORT_MADE probe filter
Date: Mon, 23 Nov 2026 20:01:38 +0800
Message-ID: <20261123120144.9278-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-19-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-19-sj@kernel.org>
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

On Sat, 21 Nov 2026 13:00:02 -0800 SJ Park <sj@kernel.org> wrote:

> Update DAMON usage document for the newly added REPORT_MADE type probe
> filter support.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
