Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435400;
	b=uXL4s3qKNxNn8N60Nwkx3Vb2/UKOJmdupO7TQpSZjsdRIPEYyF5DX3Sn10I0YJgJrs6l
	 +LIm3xCaW7hEO5VPcQiCQkyfKYSGs0ChhFMtbVsuHdY09yhUHd+eNOXeTcQ6mj0y9UPcV
	 c7olj6j5v7Nk7O5FGoqnxtCwjqyPZC3AGTSniAsk7aEAQYyN5rI2DSHWR+6m0v8mENsgG
	 Hvdfs4GH9duH8gdnU6ulpwrcAhrgXjR8+0LMWA02wQC6/dFIY/b9v5pKe0zAviWWD+YbS
	 lCMYCCzlGCpglZ2L73ulnapELcvV5Qgrr2Y5uS9UtCNyHE98BZ+C2vb43xwCDKT491A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wF2BrtRxuWZRCxFUdbfJu7L6nOWBrpCm7Go7waMKPQs=;
	b=HCjpEjWAjzr3oQdYL5JUtv3rhLeWLa+TWzbxpRXa13pr+Y6wYKFiAnGwnfRcOK7Jzdkv
	 Fo2UHQxZ4F6+9CEUqC/26DKV8WHbeSfS8gzQSwptQp7xGD1EHQY8dmXY1nSVUeH1xlBuZ
	 5/E2qXF1P+asrJag9qMKu+EYLS4xOV7CmCmuIid2oPpXpXhpVr2RpAC/5/FTr1VemJXyU
	 xxjfqGIlxqNwIzBq1ngSI8OkAL1p59D0E89GwM3YHe21Vvjjm8GWi2UgX4c3iskGE9Hbo
	 MRptCHHJam7cd/FpQHvcphHZ+7vMLsj6G8DMoH6U2Re8idT2AenMX0jbrHX1WmWKT/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uijyoId4;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A199606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 12:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A199606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uijyoId4
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14394530ec6so4663636c88.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 04:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435400; x=1796040200; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wF2BrtRxuWZRCxFUdbfJu7L6nOWBrpCm7Go7waMKPQs=;
        b=uijyoId41Yy51Z8pIU5Kh3eh39SGUDfSNF10m0UqhWcyDbTdGiVTnMSoQew9b6zuLt
         3H++mpUgnuK1XI9uOri21osl+vuQR7cCZzpxg0CIWxfHVTgrW4smd90lPvchhzXvNqcQ
         DRMcdSZVpI8upnItmhNVjVvDu+NSo5rbZKr0ej/UjvETQdzzZC8bnKXq0dq9s3Brgfud
         rwAmgmfQe9RiEINuMRD3L3upYt9Yymh/lVsl5Aa0Mmw2V7QVre+qUu7CdCZcb4+5BpVn
         +FA1qXENggSFlR7B7gFsZYA2CKt2VmK84JdqOyq1hUB4ZgkU68B0RW+gaKS/1dddugtR
         xq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435400; x=1796040200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wF2BrtRxuWZRCxFUdbfJu7L6nOWBrpCm7Go7waMKPQs=;
        b=ltGxfJ3YXdeR8c8UmVwkEy2K4FWmnTXoLXVytiz3a4n1rQPRlfs6alLBlVDmvjftP1
         yL1cLTvS855cAjBMjnjoqeQE0orjgcjlyRuzCcYiAom/nD2sJ022FX7JYEc9oT6LES+4
         J723nMqJ9HYyTu5CqCdSYqEev9mIcGK8prJ+NLEdO7oLxFnJ+t4bfYR8NKcuT+RYzPhv
         bINe4xPGoayGM1tNwQnSNTWIHli+rSDgGpRn6HhE29Ci6QfJqF/tVCkWujyNP2p6y9qK
         fg6w07DhTYGhuj/M0ROOawkFmdn6n/7rhZsqBkQMg2zzEIHlLxaPnjTjsbTf40S4Rlct
         tQtQ==
X-Forwarded-Encrypted: i=1; AL+hErEl1nmyOeRYRtDqCUIkYdhaY3BLATaORNSTsJROtLaqIj5Dei1i0dyc/nvPFAcW8GDIfV++1Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ULfkxK/lO5AeGPieSkjZM+xemcdU/Axk6tksyG8Q/hMdwUuQq
	tFrc3YD4Sn4v7CTTBJSptsIqw8zUKjl/I2t5StT3RqhOwgEay5LtMMZP
X-Gm-Gg: AZFdTZcj4XciULq0LpGtqHnjPItFVQKzmjLQBJYDkC3tTLy+GNWeY9EvHpjd1h8MkvC
	a2AtSck4pX8pn8k/m3/xK75uJhHORcaZo6OmCFEVIQR/zrprtfC+Yc2ojbffL4Rlafj4ORl2N3K
	FvdI7AEP31/v8gHf7Ylv/hQ8KZOGfYCEGMFfA+8fj7Wy7j9waZUIsYUHWJLNkFnI51vV9UlV7Ah
	8a1wEr/LT8f6LfhYCcflxpCHM3YZU/Ujqd0YCcgkgKeEbObqZNVbWfX3bEvUKjiM/2GpzLDaEOa
	9zWmC0IrLcHy9ECDPsQ47rHP2hRIaruOwAGwMI8uE/QZwTiKg9RXcpeNz0DfdVs/bMxLe3VFerb
	/HccBf6rbZnSi0M5TfXf+/GBMN7jFbqiCS6c0JGQpnrFTmL7wwPp5B6mDFutcinb8wysCxl2T4n
	h49KZVv20wRGCX93MXAHNu0N71xjO+okxvhfOjwQtGUfppMkf+EplMSrbzrN2FeQ5WEKP3Y/YKM
	0P9HsqkjGPG0bu9SplFe7IaP/GcfRpGKWMus0NNF5wkHQAnhiSXNsq6s8pUuk1G4KwH3eKMmH+u
	MJgT8HluRa0k4lrjPoS3utQPDli2YXRC3k1QO89CsWmde6yQLWarF5nWcyx155h1Q2Dk
X-Received: by 2002:a05:7022:ea8a:b0:1b5:3819:f8a with SMTP id a92af1059eb24-1b5569050demr11450885c88.38.1795435399661;
        Mon, 23 Nov 2026 04:03:19 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c3052sm27944108c88.1.2026.11.23.04.03.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 04:03:19 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 21/27] mm/damon/sysfs: add user_report support for report type input
Date: Mon, 23 Nov 2026 20:03:02 +0800
Message-ID: <20261123120310.9444-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-22-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-22-sj@kernel.org>
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

On Sat, 21 Nov 2026 13:00:05 -0800 SJ Park <sj@kernel.org> wrote:

> Extend the mapping list for data attribute report types and user
> keywords, for the USER_REPORT report type.  Use "user_report" as the
> matching user keyword.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
