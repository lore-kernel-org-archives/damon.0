Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598383659F9
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204952; cv=none; b=FOYYbfHMD789hfYeX/clY8V6O/iKckUrNF5sko5DaJKEl3JXZU2mD1DlsWNBuuN+zoruqVgosB8/sGyEVAx1xmvR7J6nQDJRmVtIvAAt1LdMV1sfWLzjQrxYKkjcAh8B6pmgmL1f7Xa2CSCByCNPYMQ6cCMeOrjj1ABoxcV6HMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204952; c=relaxed/simple;
	bh=zkNUJx+HlgJnr+p+9JiZykZ9vS8T0woBQ17Dvlfm7BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+bZmHetlPkIws0iOIaPnzYgdpKexmCFSBWUTEcRgXgawoPXpxpmpuPnME3tjbwSUuFYcPCPIB0XdDiokAnPj2DZM6RK4+6aLM2nkF7MuDBDF2BrJWuNwAJsTqAgkdnWCVHF0KQ8f6N74V9C6Eob0agaAkWO4ERt05rL+vmR3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsycfB3n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsycfB3n"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b258576d8cso10817435ad.0
        for <damon@lists.linux.dev>; Fri, 03 Apr 2026 01:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775204951; x=1775809751; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWARIkwYvEXgfZYjG+Wr74suArYFrPWiR7izLuuH3rU=;
        b=dsycfB3nLyX6hxTgqiwXXe6FA8RbrWfjisFJOyqiG4xiFdiD7c+HdbHi2pqQTI87z8
         Lz+HaeFWQ9SOz1anHCjBXkNf+NE9c9jZxauCBdBnC7uNj09XjLDorRaIvvt/1pmQ68+W
         F+kmdKqUtwP+pV3XmAG24rOcqlbO99vSLbVu2yxoOpCssmZW8nTlrhK/njlXTB2M1xFp
         n2VWgtKPTrwANVAi73PlGSIObbcGHYbRoGojdXF0dF8VRsaatjWQXB0QYUdb5Zy5IF+H
         AECWOExnTdQ61U3Z1REBUNN2ZXv1ANYUMR7SFqeimNr/SvzDFefdznaEJ8+b7/bDl44h
         2CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775204951; x=1775809751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PWARIkwYvEXgfZYjG+Wr74suArYFrPWiR7izLuuH3rU=;
        b=PUfRoGnqttHx9hxoW156wxJl+7naTrAWKsBKxGwwCY/5uyC3PFJXOxbZJZse4C2Wwq
         il90NLuvLhrl/sWsgY/aWak+U6N5vxUhmCa4ZEm50rG99/laEhbUl3Jo6IoRvu2jHkYc
         RgiqDv5/r08zevNmTVG1xUROcBQVWQmVlchd55s433F4SoiYBID65NKX5HK6y2Qd9Gyo
         O384bfJ1iRcW2CAvSVL5WOM/4Ajjil5qyOCJ1Tx8LeiG6c5wZkCn21CaBcNF+7Vn1Y44
         dfhzzU3yehCDdVIcFwoUyTXEj3sOkumYV4p3idkAxM0aG1kE5L4mWpNvAs0uNfZUmCWH
         eW4A==
X-Forwarded-Encrypted: i=1; AJvYcCXrc2zNwS+yfOVyW96Th9IhOS7CR1ROQ2y4YHnzNve2XMnG5MXTEJ6O3lOmvxotJtlbSD/9uA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGRdNiNHySbft+3jZM9jUsF1CPzQM0Don3Cz3sThtRRB9OdxXO
	gm0vBm0BUcvSSnJi9HPf/1bI2DwsKbadp3bR38yHWebcXN2ZWdnRFt/o
X-Gm-Gg: AeBDievlPKodhyYGV0601zGwbcqJ4qy2CEjPzbnqL9GONGp80A0JLUt/peJ1c6W+TZT
	8XPX/slQm2D3iTihEln9F1fWuSzKJGK+EPAhd/CTcPcv+aZ/6ZMRUkJT7qELJco3RyUHSbHZLJ4
	tkJ/8xwYgCOw4oVK7sm3cwyJYMIy+iCwfAPHK2TAZR+ko9a7gQaG6Xh9ZICw8r2btLYIBDVAmGu
	3ifhoBuaQFaczWiGzZNIhkS+HVD4FZHOhVYzC/oibP1btsiJE7mvh8HWU/RyhIPn12MN5RwqG0Z
	PXVOmPQ1MRzSIdG+6loSeqCjaBGK6yZln0xRKpgbp/Jz61624yeijHGwJxgFpC443nGwCjo+TIT
	V/7Q0g9CqlWku/qKLEr7hxsGNI5Bt47jgWoDNBJJxm3eCHXz8N+n8aDVhTit6mz4s+mEsNhdX++
	OO2T6UfqgYZUQYNFpzLttXO2LCg71lPEIYvVal1mgR7VClq0FyGck=
X-Received: by 2002:a17:903:22c7:b0:2b2:5203:acd3 with SMTP id d9443c01a7336-2b2818b3dfamr22641545ad.26.1775204950671;
        Fri, 03 Apr 2026 01:29:10 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a3a1asm50469845ad.62.2026.04.03.01.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:29:10 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 16:29:10 +0800
Message-ID: <20260403082910.5346-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402140314.74600-1-sj@kernel.org>
References: <20260402140314.74600-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

Sorry for missing the discussion before sending out v3. I was too
focused on the code and missed the context of your questions.

On Thu,  2 Apr 2026 07:03:14 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu,  2 Apr 2026 13:37:56 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> [...]
> 
> Could you please further elaborate visible user impact of the problem and
> reproduction steps if available?

Yes, I have provided it in the cover letter of v3 [1].

> [...]
> 
> Should we add Fixes: and Cc: stable@ ?
> 
> If we should Cc: stable@, and if the changes for DAMON_RECLAIM and
> DAMON_LRU_SORT deserve different Fixes:, I think this patch is better to be
> split into two patches, one for DAMON_RECLAIM, and the other for
> DAMON_LRU_SORT.

Yes, I agree. I have split the changes into two separate patches in v3
[1]:
- Patch 1 Fixes: 
  2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
- Patch 2 Fixes:
  7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")

Both patches are now CC-ed to <stable@vger.kernel.org>.

> [...]
> 
> Seems you forgot the patch [1] before renaming of the subject.

Thank you again for reminding me, I have added the missing references
to the changelog in v3 [1].

> 
> [...]
> 
> The code changes look good to me.
> 
> [1] https://lore.kernel.org/20260327062627.66426-1-aethernet65535@gmail.com

Thank you for your review and patience.

[1] https://lore.kernel.org/20260403052837.58063-1-aethernet65535@gmail.com

Best regards,
Rui Yan
