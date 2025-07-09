Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAC18DF89
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022868; cv=none; b=pHwkPieteNSV/M26aS/MjK7oi6ZpU+2pv/u4Ih87dj4izDKWmJitqhS51imr43J6Wd4t6ObZR7l2zaDJ+L7PTCUXxkIxCEvG8NegWx9eI/JeFmiagDRHi43pkRgCovOjefh9AHt9D/E6IiG8Ikne4WvKsAqWzWYMm2u+V3nVDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022868; c=relaxed/simple;
	bh=K439CV0Hr790Er9RUMtoSY+/LksLRGeekuflMOjQ/tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEg4LGQyirYO2KDAM2oyIJEN1U/Qt5fsaGOirRQbQ7oAVnRHjdjkoAtzGvvyacRlhor4s5Wi9JXUjxtUsrvMephjwvippNXp0XsoCnDSVYK7TDZ1Mv2WPnTEpRWoPNwqjqgi6qCOM95D6JCej+7/0lV7CIs0Y9vgwEWh4eCDmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb4iNtxP; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb4iNtxP"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e82314f9a51so3898516276.0
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022864; x=1752627664; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4j5uWVr2okio0nPQPsshhbU5KAvZtN3lS96eXXErJM=;
        b=Qb4iNtxPF4bMS1i+aaoMJ753/cjB0cB1TcTVpDgz/dyDaebbq4zagZHTbp/kWzXLQk
         PHdLZ1FFr+ZIi38DV8ksWe1EPTKixs/DF1MJzixh5w5NfBtcOwH7Liw27lh80Iy/FgDU
         cthol2+isdTaiuf5tcRIFyNPuLGWGVtle358V6xTqjkEoeNkBSLbVEtrwwnzXHOcBVsF
         DSwbu3bNv3q5EWX+rcA8NuzYMxj8H9zRQ3KLZ6ai4nPzHI4Ol5GwmKJa4FFe1N0GBWSL
         ouZDZ7jchRHEWq51URUMCe2Ws4ei4PgpIfuceyB/QbIrk1Ch4xvhBSmE2EC7bOMQVjBQ
         iCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022864; x=1752627664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4j5uWVr2okio0nPQPsshhbU5KAvZtN3lS96eXXErJM=;
        b=UFaC1v/trVGqQo7lWUgF53gPZg1tPC8OrcpAJpAyvNY7X4yYZSsgJfk5C5KHBAZ+nj
         ldk/SNzIJ6hBa4kBxk2TgjfWuaC+007XuQ/OblE1frKKPKy8O6dhAi3w6DyiH7VcYDny
         hUMxBZyauMkFw3LBCAi8bkXV0FIIDF0SUbIDjz4F0ItYiXPiz24x39rG23CP7XMRneQP
         Od5YXBHBrHGn4Pcbk6NDVgHpPJHtQLEmPD1APc5uXi2wBidXE/8bCb0If72p5emSXmlW
         qzU3/Tp96o0Hu2kNWjGoOO2DtWFF5xU25vxZvQBnwNF6ZToHnvU9iNKedt88ve0U/gNt
         XTDA==
X-Gm-Message-State: AOJu0Yw04BtxVmsDob51TSbzu0ysRianfeIBvwUwzuBZaiOJxCkU4b8j
	MJ7yggbzItwDAml1Zx1rw9MzgjS5xeLcCuPijt20xrIlHQntIunQaPXJl94EFkDwWcI=
X-Gm-Gg: ASbGncsPxt2trlykoMQ7hTjS1+f2egn1GIp1qarl4MdYKg0GaAwkX/gaWbYEWtM68OF
	BhFnxmTy1VtqgJFOsoPmte/SFhQU3jlq69cwo81S8f8yyRaU3M9R+m0h/YyKMH6TWW7x+JV3XL0
	836uhJh7sIt0iTjRwh6UZcVVpZpPtZnuhaJnMcM8MGGFfhPKQM/+Eegtwmj16HF/65XMMTbvJBx
	ETYj/eU+OcRZ+0wGMDAhkoCGVf+RLmtPANqsCmHggbenNkayRybVmgvwdJ7CvWbWtrRVzNEOj5i
	r93dJGj/1PiOn789WcQqbyxTt8vZzEZyn1AeFi591H5/GTMswCwj9p8bXzmcgiAPnSqZgL2LR7g
	iFkluMEw=
X-Google-Smtp-Source: AGHT+IHLPdZoeujPLqUztp6UuADx4QDXfITwDq09vzFE768onA06GI5SAONpI024p+kEEi9lspLVXA==
X-Received: by 2002:a05:6902:6886:b0:e84:1f9f:1344 with SMTP id 3f1490d57ef6-e8b6e0e4588mr825062276.19.1752022864185;
        Tue, 08 Jul 2025 18:01:04 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:01:03 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [PATCH v4 10/13] Docs/mm/damon/design: Document vaddr support for migrate_{hot,cold}
Date: Tue,  8 Jul 2025 19:59:40 -0500
Message-ID: <20250709005952.17776-11-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

Document that the migrate_{hot,cold} schemes can be used by the vaddr
operations set.

Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index ddc50db3afa4..03f8137256f5 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -452,9 +452,9 @@ that supports each action are as below.
  - ``lru_deprio``: Deprioritize the region on its LRU lists.
    Supported by ``paddr`` operations set.
  - ``migrate_hot``: Migrate the regions prioritizing warmer regions.
-   Supported by ``paddr`` operations set.
+   Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
  - ``migrate_cold``: Migrate the regions prioritizing colder regions.
-   Supported by ``paddr`` operations set.
+   Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
  - ``stat``: Do nothing but count the statistics.
    Supported by all operations sets.
 
-- 
2.43.0

