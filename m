Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795355398;
	b=zUF03M1Na1Kf5s/MTCA+Dhi5X7y6MfFgXVM9QTS+eg6oJYnhSC7yPK/S3MjDJK/s7QbN
	 W6edcpE0Su2v22PbLWONETRUhDI4qe1mYiZj4uza4w5s+ak+wWfiSZtyuBA7THeYGPUDC
	 GW9XYo3Uc1Jnd9sG/d5aluNtNg2dIZRmtjRoTSW9dmzud785Q2A4mkUZCarKsQEYs51+O
	 CPG0YKKQAxCUfNT7xdZcYhrV93ous6etH4BhSt7mTBfV3ac7uPdPpAZolm4l3A6wQQC7P
	 ZJyh5yD+CNPFF9OB/Ir0vP/q+WJMze64an6rppEKPOmgU6Mp8okRGezh0weg8yhTdXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795355398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3i5MWPEyN/CFOvI6c1AJaNV17PHJ0xdzS2s59Cs1Zeo=;
	b=1c8EhE5OF+Ym4PNvc+zYyp+r7crEQwN0mDCQ2RIOOagwd0iMOT4hjyNvrAhoQ37vA3gr
	 bj8rv4d2xXwsk2B6THfyAidhd5J2m4uHE2g1JdsD7Wd3Eem1eYrm1nyAJ1fQ68cGYu8/8
	 W3qvniMmvnXlV4djiZCYLQBOix5BzZnzTEOMGQhaTPe/Ov5E+cW1757TJG/AJr7V1zSUJ
	 +TXD6R1ceoBZvtFsbAnJPkMwdT1kK1lq6iH+Pa4CA43pSVTCG+f5XQ+Yk82KwY8ZBvBp7
	 nMeA8N8WC7rVY9pkTLzpZoHd7U1DhkZOIoUdkuH2e50nkYR95OEaFmkOLF/HPZXK19Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u8bFLNJe;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C3606A32C
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 13:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B55C3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u8bFLNJe
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so7382627eec.0
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 05:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795355397; x=1795960197; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3i5MWPEyN/CFOvI6c1AJaNV17PHJ0xdzS2s59Cs1Zeo=;
        b=u8bFLNJePOOik+AeHlo8QMsZllXUBSnxt4ZQlNQryqPyifbN2iG+R1SCj3Uff9aEuw
         6Ap9FOlWufMhuomgQT4Qid+70HeCCmgAT1Xo4JJQw6VDQLJ8xaLN9eFLcjS3MJ+fgkVf
         vaQH8j1mrcP1vTUKDQ20P0pTOxNzVNPD/k872nU9f9EtNO3dobetcdrQxwBaqj6bILON
         2Bxa1YsEcH0FYaYxyJbmQvHu62bS+mCq2bVxv2ULB26AWZJUv2rmEf3R5cvz4DtIIdMD
         OH/umZuJutNVgqO00Z2xNAZMa5fgjFr9v5XHRt+QSWRRzWVCpEm1RXgPt7suBukWqFvw
         szRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795355397; x=1795960197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3i5MWPEyN/CFOvI6c1AJaNV17PHJ0xdzS2s59Cs1Zeo=;
        b=jIAOqhuZIo53WEwRMRwrcJgq1nldUS5SvmylwwSt3epM66wUAUJaz2v78l1gWIYZ9P
         IU5Er1Dzz0ZZO3FiBhsQn8Tky8bPfNngst2RaLdcv7KTyGeCtjwn3aQq6kJf/lPNfIG4
         lJqdBfRp9INZ0PL2j/NZaFwiPsoNenkA0B36i2+L//eZ8ufr5Byg+bqIdFm0ZjfMOz+F
         rRe5UqDvR01nM9tQq6OpUIReNXXJ7trJ1l2rZFPXT3RHa9omlVhaLvrYi7Alm8QOsJtF
         Jvg0f2Pgp+F+8tZS0pmbp80hhSm9X9H1WDDBUtu+CUPGlQK4s01OrOii44DFmW9H2BKF
         fMHA==
X-Forwarded-Encrypted: i=1; AL+hErFgRu8XaOCWMtyfgIGfzQam67vNFul+SZNAUGIKoKZigeujSs2Edr/tArYNzUrsf9QvsHJsPw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/3DjRQtvTQhfn367SeJ0J+s1H/oeS025G8fGB3pKei0pAe1dE7
	gEwncdXenvJfW4fhl/oufkfgSpwLsqRj8eZ8Szec8pLWThO6LZUoEzR0
X-Gm-Gg: AZFdTZcRJh44CtsMaLHKXTtdFmAu3nRkFjHtb2koquR/wg4iPMwL1s3RuIyzo6vIOHQ
	lkBytNR5U42E+rrp/zUc8PB6/m1fuDjVeFw2Mh3RmxcPWfG7nHF7p45fzwH423tYK/lmls3p/BQ
	i+LvYlQ+2c1oHAJViLBjRH6aejea4HbELCbdsm0JvBDS2HihLKOEGjhTNU69ygs5OpPZGy86q1w
	l3/AjKxXY3wdoFgjuviB8zTLPanm7H4boHnx4+SaNr4MK0ZxcQKNOUpXjWIKr8MTrOzHCx4+WqC
	39/SimKR79m7a5fLtjja7YJ5wPs/yBpuinAnMeUeM8GnepX8dEPzprTkEY7wopLvB8aPghZ6q1c
	qS6OF1oUC/cRWsQ3PxPetBur8gFD6kQCH7yD5IzDofrhF1wipLzzBF6TNnJTjzdW9B5mAPRA0WI
	fziv/6I+4VYi1lfED2U15Rf7vjB/AhUPpOKAnPZn+pTJhaaV3G222sr/KiWVCP1yjU5sfPOS59m
	SFIL482TS7Jg+FwWsWq9fEqIoAOpDUiostzCQf53NHujxmxgQAp6Mn6RTMxQ5EoNPsUT8rb7ape
	gkoTBKxdXoI0E5j334gVl+z7M4FXV39u/ezhckinJE/rgkuX3UyWksR6bOdD8UGq/Biw
X-Received: by 2002:a05:693c:4094:b0:384:ce59:5e1a with SMTP id 5a478bee46e88-3856ef457cfmr11343027eec.16.1795355396721;
        Sun, 22 Nov 2026 05:49:56 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm20925807c88.10.2026.11.22.05.49.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 05:49:56 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 02/27] mm/damon/core: implement data attribute report queue
Date: Sun, 22 Nov 2026 21:49:13 +0800
Message-ID: <20261122134939.76758-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-3-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-3-sj@kernel.org>
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

On Sat, 21 Nov 2026 12:59:46 -0800 SJ Park <sj@kernel.org> wrote:

> Implement DAMON core internal data structure for queuing received
> data attribute reports.  Initialize the queue for up to 1,000 reports,
> inside the DAMON init routine.  Destroy damon_region_cache and reset the
> pointer for the queue setup failures.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
