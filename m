Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434574;
	b=gUEaBOYjdHAK8mRihcthwitvcXNvESt+5U6A7qqsM7sNFLOEyAJx06ByfqeXiSenpvYE
	 zUVHAE2PwVGqcRUwXSIO35WQX6Z9mtO7GF23WNsya1Igzgneg2t/uf8fld1lMaJLLL56u
	 Q1KEQzw0L6i0Cqa3vBqI94P+UFVLdtm5TjtXbStbrXtwglIvvYyePqITgexDcOnswQwSr
	 lgJhs0C2WWwf2ua0CIjaCgfpze0Gcd1oLe7zOzTjhGLU0Zekk/pK88Ayt/W2qfrkmmBay
	 2Mxypb5qSJ7GR2s8JEneEpby3p1JMuwFCjOP2yAwHzQGgoPMaXhSqZH+4kpvd3rG2Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a1BeAqyMLOMCEnXc3bmxJk/CbMYm6ur+mByxDHIeAz4=;
	b=JO5se8cdom2hsj0SLUtga+vbbGqLe1ERZEkuRCGYvHJ7YgsYPn2vDUxkwtHABdQ2LLFr
	 IL5k8/mcXlHiP6moKMaQFiLYhMONdqA07Uf/sveVCpRveaxGVciW2ufOymaUSwcUZRjJ9
	 jFYqKAsDl8O7xvx9ZkDXG6e6bcb7fcXrEp10YCaHdlk94ydCbXsnAXo5csRGNpk8xroz+
	 oYe+bpatcK26EWFvKTVd9BZP5MwQKl/3WCEIpPO1sRbt6xUShSs44oam0Dz8fCqzpHZuJ
	 CXbgqN5xdu1lQXUNPbd4J/ww9jtnzrceOXUHiLTdaZj5VFQ1iUeCmkCWpAvienOQbLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EY79b9mw;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813BC606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 11:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 813BC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EY79b9mw
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3866a784546so3986359eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 03:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795434574; x=1796039374; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1BeAqyMLOMCEnXc3bmxJk/CbMYm6ur+mByxDHIeAz4=;
        b=EY79b9mw+/2NQwVmUX5qEgfJ8pYyBIcCri0fk1dog1eZRMV019tgus0kKfdM+zGvaX
         lfBGI6wug9ErCMTTAWLI9x3a0Nfe0mPmMPAQqW+LnwX3GHw+KgTMc58VXIPqLC/zRoi0
         lFRlIMD8R5phjD3jLKm8M4H71ZCKQJlAkZenEdA0d7506APkgC2gk0lWQpvNw2WHSBGF
         gbLcJLDiGLwhnMKEroVkrOzc/uxcmGbtOn+WVRiCB4Ef/l4Y1pakHcH0lU2COSlzXVkZ
         rUDi0HR5gywlVb/hYVbUyC29UEy9nMDbu7CFZO++crmpP0dVjt7e+iPeJGGgPAqL9t8g
         wv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434574; x=1796039374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a1BeAqyMLOMCEnXc3bmxJk/CbMYm6ur+mByxDHIeAz4=;
        b=z3No4mtzi3s/z3xrc9iMpYCZDOcBG8ObRUL/mVu88+osYP4SpbbQIB4BqZ9QaXBATQ
         cChh0cSeCqdzjaTD1lFucYeaYb3Oy3Q0de1GCJRtsm1jraqMZK8jEyi9N+SEjX4QCA6s
         +FgQHsHj8I7NSNTnvVjJxq/Y8IGmoIXiDtP1Qwt4EOHvGYzI4n8wILqrUWNcLCpUYefN
         xMCvatSTanju/KB401eEoMFFzYaQGTeryvPLO4/Me7omoBFunXZqM2YE6Y8Fh6Em68Ha
         VJSsz3aq5NhbOU0hYBV0COKa5n995rykG/LsyeBVK8j5Yi07S6Wa99v2WN6LziM5DpdI
         8akw==
X-Forwarded-Encrypted: i=1; AL+hErEdeFGis9gXad0Pzfhsn6Y+zZSbQW06mRt7jS9bFm0WEUyGv+AooMK99lK9NQrPvjwAgIAfIw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/cNG/GIb7k1XYjcmL9SSJX/hw3ClVLJZqs2TiyWe5erZkX1sWg
	tt5HBe7CeDeJHWU1/c6uj7Jrky2uypFKxRSUF8eEPIREgqcJBn22WSaJ
X-Gm-Gg: AZFdTZfCExuQwDzbDW4lTZa24XeLRQQw0BQbZaQJN11CBNh/J2S77+/64TGh69xx290
	YwxTY1YdiUBPw2dbVcHdNsDyX6eZ2ZyooOJ+YT1rqKHnS9jDhmMk2SBavJmsy1276k5gk77GlkK
	ztXg1r0eY7SRXwM99mOTLv4KgXTZIjK5OVEGzgYxCNOHwYIrf9+XhpVoQUlEjfhzZyDxgWgNpZn
	dPbE/BzOm5drjWc2MBukydP8bpenF1ULbrg9ap+LGKTThxb7vUjYoF368KfBhWW5+wyvldcNrDm
	hmOkVDmtwL9agLNZqtggdG3dowvo4ukRXpNboZUWxKOHl+QPmmQlwK7mM/Q4q5PJ7axl1hi27SM
	HkJvmJSK5TKtPCFEvl/r7U67kGursMuspcV0Tj88OY3GduPfOTbagGI6bl6A0jsrQodcwB+Erwm
	r9pT8kEjpzSGeTDlbhri9oADpGUqRMtkr8j1W51s83Zr1REpm5ArA9s9pvYZHHGQmV3bQup+Vn3
	f0awyAU2a3JPiZb+59NGRjP/9UjRqOOj9sCrucKoCGK7osudx0xwWmccVamPZj3PSZH1pbmZ/77
	sXukgKfTVNfiNWCMddADlOuj4kourYjtzpQ8uzraQNrWRqsC37K5HxMsdR5/t4pZRpjV
X-Received: by 2002:a05:693c:20c6:10b0:36a:15ee:c20e with SMTP id 5a478bee46e88-3869a150409mr8734857eec.33.1795434573583;
        Mon, 23 Nov 2026 03:49:33 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm31501330eec.20.2026.11.23.03.49.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:49:33 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 06/27] mm/damon/sysfs: add producers/nr_producers file
Date: Mon, 23 Nov 2026 19:49:17 +0800
Message-ID: <20261123114924.7369-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-7-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-7-sj@kernel.org>
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

On Sat, 21 Nov 2026 12:59:50 -0800 SJ Park <sj@kernel.org> wrote:

> Implement a new sysfs file, nr_producers, under the producers/
> directory.  The file will be used for generating directories for each
> report producer, in a manner that is similar to the nr_kdamonds file.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
