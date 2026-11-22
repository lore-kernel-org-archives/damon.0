Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356000;
	b=spDWP95C4fWaieR2tFyMWWMemlCsqBAzep7AgoscT6rBOxnx883JJNd2R9xVFkxFWqAR
	 3p7k9WrwOV9mm8/AK9/37UVGRpeg1BjaNgfnQfsMNjOu76jsGZYPU0gHFK/Dfhf3sS7b1
	 RXFwHvc6l6mVvkgOQ3dAhGlN9MhtzwIEuWGq5AdDI8Rtb9ApFy8mBKUv6wO+trI4bsTDI
	 RYmcUMLJLcuG+dTzg6kPz+Yf9m/ejhSccCyYoXR6o+zYQMG2K17TDkfmjsQxmX5HKeqHy
	 +ZTGIw8dCONuQ8W4pz8ENHgg6ORLEbX9ZVwuV5TuW4BTk5qbsu3CCu59awRMi55ti8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=990T3HNtPZH3bqJpbncLzkV3NXRnQ92AeqD5qJtei7w=;
	b=yDBXg10QdE1poN6kEbrBp3DuQ/PqiAhSQwAwReKOFu10BRU8Obk1k5dSD4W8ZPoHbXCB
	 YZ8trCA7FpQeM++9KRC2qOVGiABcVtN3IBF8WA5whCdG5fM8uHwjWecwvDcm1zBMybATO
	 WLrb3GHu9knvH5VPFSPvftD+IUCzFISm/gCaYkoXlgqhLBG+uZwMHJYkh7DCGIivKHeYj
	 db/rMEEdMQlrpkdM6nhnmQUj/wvyNP0hGkyYPtt09eLZoN9pN8QaqpMcrfHUGACeSOvvT
	 rsZMd3S39SqCc6qg3ylgWxgsRqXFq2LR8mOtNrDz9z/sYWl39TR8AmG5oWbHDfdSjIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JAGdJIuk;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C84606A320
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 13:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C84606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JAGdJIuk
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b3acec6677so3477984c88.1
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 05:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795355999; x=1795960799; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=990T3HNtPZH3bqJpbncLzkV3NXRnQ92AeqD5qJtei7w=;
        b=JAGdJIuk8ohLIUnkCIKLAcsVTPT3LFeGoUOm90iQa5RCCkEvq78ya2SNAVpwgOfqfH
         iTz/aCoacvbx2l7dh06rENsrKumTS4/vrU2LRyyF7m+eIUxrYsslD1EpLSqphwAKNXww
         8SwiQen/qZ5QyvgI9f6lcVNOm+oEWBBcXV2oIogLI54vUGxnAQ6AK00FqobJVjEk4Xa+
         mYADgJgAEUDs9LxeqVt/5jcGwGMNvuqCwZAxCPJAOnoHC7Ex0zrOpMT1cceaxKX97qJy
         j5Xpuet48cSk5Qv0n7SrjB5E/gxEB6+4PJKLdtnBphL9dgX4RR2eeqAF1m1FR7n9UxrQ
         BRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795355999; x=1795960799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=990T3HNtPZH3bqJpbncLzkV3NXRnQ92AeqD5qJtei7w=;
        b=CzhafsoMzToerha5zC0xor1iCHasQx60BrsyA426ejx78Rq9u0fLry3idoALW7upeX
         +MmoXfk+3yjsYrE5FyMw7rBMkV4FATmIfn8BWKisj/1MVgFsas2CM7RZlmYhZp1pgs5O
         tLHVzvLawpyohm/3Jos31b94Z9xl/DPAPlfEp0ZJuQ+bTZBpbBKR5w8fY49Wi7akzj+h
         /Fjpcthujiu/yC6eSmYrYWW5v0Ko1NhD3ET6cja9Hin7eM7kFIsXmPQrtYEKocClFxRb
         IE041arfsFIKYa1BPDbJ49UtB3TpHuhwIpVjCMkeffBavJB4MjJyMYR0r6nV4Ym+N9Ld
         vGUQ==
X-Forwarded-Encrypted: i=1; AL+hErHbY6pKsZglMSBgOTn7uRsdrewUulvWkt2Hm03ijSgSJ6fziX80keRMIQUhBP6w60fn9GOQOA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8tqg6lCLT5MLkbEynHbkRyXKqJlX9svn33gcyioDbWrAEa4wMO
	Bf3HgSQ7OPTKsHjBMNU80xKmlyvTH8scvXPKU2jfBMUuFOTFZ/TVQvku
X-Gm-Gg: AZFdTZeUQsFupDsBbcUJnN7h8Pd3F8lA+g/BPT+FX2aR/Bb4RLgInSm1g+ruzHzlQ3J
	GzZSRLPuJRN+IRxGwhxTRPOuySe9BEk5ooL8OR3rJnKdP1TUM7lFWbt52194ugW+XDfskW6AzE9
	TLsYECOlw//gmcZyU5hcCWIm4k8Odg6OQTyAg83xbyu2/m/SGNmeFsPqqJZmGjvZSw65f7YYfIC
	cSWezs6eIPeg4f45FtxAWbr4OlHzapwfOPbt7KM02Mj7hS7/rNg4ql8/UL+BOe3IuLiOFRrFl+z
	dW/f/f2kNOEMd8z6xeHWbNFCf6izL0Vhriqa9lxyIsBp5Q9DVAXHMxYgRfftgKAUoOy5/qPyLBk
	eLUUr/82FMZBedf3dQT5jzLVcvFmN1Td/I5WXU6sE1rIMBY+cYKhfu/FLvO3cg9I4cBb9oz3KYP
	wQIyn7bYG1ve+mH9kN++1bipCWDdHmD87xg9BdypGYr234r3mRluld8Te7I++6EpNpEj9QMckcF
	v2elkys4VhIG/kYY4klEGlijry0jtIJVRLyb8ewMPYlGcxxozHPdyumvKOZBr8VghPO99YFsplm
	bWJvH8BRpBxwEtT2ZzU4YnzyuMSHAiDKbTtFOwbs060IrrRE7OIFKgkeGLf78hzMNL6/
X-Received: by 2002:a05:7022:b909:b0:1b4:f3af:355e with SMTP id a92af1059eb24-1b5568a660emr8203471c88.13.1795355998971;
        Sun, 22 Nov 2026 05:59:58 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm20585980c88.3.2026.11.22.05.59.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 05:59:58 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 04/27] mm/damon/sysfs: add admin/reports/ directory
Date: Sun, 22 Nov 2026 21:59:18 +0800
Message-ID: <20261122135941.78688-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-5-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-5-sj@kernel.org>
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

On Sat, 21 Nov 2026 12:59:48 -0800 SJ Park <sj@kernel.org> wrote:

> Add a new sysfs directory, reports/, as a place holder for sysfs files
> that will be used for controlling the data attribute report system.  Put
> the directory under the admin/ directory, next to kdamonds/ directory.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
