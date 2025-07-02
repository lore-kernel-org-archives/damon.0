Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A82F5C3F
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487296; cv=none; b=jI99+6jhOY1mbRPiB4yGA3/Q3xU/9MBxJdPhO43LLyyeQu7ViMKifI1Lh3Fn4FQW/wNusQ1lulAifOZsUbm9jJaYn2wvzl80BlI1MggFvJhao+xfbJ7FU6afZLHBP7EdT4SzxtHJUyXXuuiQfzvta4Br+0VhBpGNjpm2Z7g/vYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487296; c=relaxed/simple;
	bh=0sgoYcwWoSAXxh3ePsTxskwFPgTsDHkWH4z1QYpP3pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3cVH14D8HaQxpEjSuam6An9KPdOAOw9l3pfG5kph8UZVv//SITxNAKIu5R7nCKIBmyrkWMJ8K92cxNtRZkdmfGwmmhIrwItJ8+0ncn5D7gCiXq14tU0GTQ7QCa8XSxWflLNHcN81MzopJk0/1z6lQCZ/B1XlAFNTq45cmOxxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEMvTeRw; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEMvTeRw"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e898fb745beso152142276.1
        for <damon@lists.linux.dev>; Wed, 02 Jul 2025 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487294; x=1752092094; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkS0DrkPKM+xK6PaTOaoNpfP8nOE8wUiT1pJQUSyCG0=;
        b=HEMvTeRwHQsxLKIuZvYg2syZCrJ1sJzSLQytSRNOKjrwKinE87NtbOKJrFT3cVY12t
         VBIsNpJS23Z5nsriWOhOoxEM+JSweraF9q9kX9qS2GCuN10q4onnJduTlXdqkoDMlQUg
         VHAKRWAWAy+I/eUT7IyWdttOQvkq4ggHNDhECRpSY3syUJqJkr0ZhbPEIObF0z57imrL
         +J06Z50J06vktJFA8z7vQBPL9t5NplU/t78s4vLMd6aXkVvK1G0Up2qanSu9Lyo9TVQZ
         CpuMix/eWt4HGdTP5ePife3qlS9pXhhlMvWjFNeYb5EIymrmJ/EVaaVWzTYXJ6Vim61k
         6JTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487294; x=1752092094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkS0DrkPKM+xK6PaTOaoNpfP8nOE8wUiT1pJQUSyCG0=;
        b=iOv2hd2sG+zyoHVHkRCJRrKehdQoA0unTDVuXnTPrwih3ajkUddWG7WnAZi5USOtB2
         TalcUzkJGy9uWOGGiHvN0kQr0K/P4dqtJAoTdhsl3AcocarDM24hr7Qx4SYsOR52J8qD
         DhDwTeJ+gzCRUutA+O+cDQhOLzrRHxk65ATvxCIOWL9H6nG3YUeQ0/WiGBodd8Igljg+
         vZWEpQuaZC9Pm2ozKYI2KftyWAtVuu+R5jnMUO41RRf5dQhH7XSHOVr0dXcsqftFCiri
         La7TWikaEOootHnFFV/b4/lSCbsWGGHkS/kMZNXRHuhlw4VtCqkx9NMOaAjJb2iaeZtp
         bPUg==
X-Gm-Message-State: AOJu0Yw0WctMQgdAK/nnfN97oIFWAC+6xfJ5bLB9FNhq2TsVQ5Psv/wl
	3daiSKDhLHFOafoKRsBbeyJp+aTWr5nASSgeJzuJggGFzf6WUrjzLmPGgQD82sz3soU=
X-Gm-Gg: ASbGncv25To0CjXylLJwjf1LzbKmttOEPXNME8PSdPpbnVaVeWyvRb8Lj5lmtT+EOur
	ydecEl+qxfaDlw6BBgMPcRhfZX9exWgwttH7JqXJ3Ylf2VXaNJWGZ3imWGBY2G9dbhCAG3gjZGR
	RdFs9P8O7hEGpLU+j/GLlLR0B8yhGoNfsDifsHPD4zRoiQe2Io1lUIidNTzFJdAG18ekRDDavS6
	DQ70rJ7itqwt0gKMwmbbtpd9we0CJDy+bwdmKdoLm+igpP+nYeo1H7GBvtDJxXoWXQDxAX9FGAR
	vsvDuUzKU+rNuy8ZdDc2ntzN0MWKLbUgqwn5vJNeWk/dIn548NdbYJ2gz2Dcg9CNMCXf3z5T7LW
	wAXqxGbLOZhipj02RZg==
X-Google-Smtp-Source: AGHT+IGm04Vh1HkDnYwneNGvCSl8gsp/I7ZSqzh9/jiYbz/sPZZP1V/Sh0Zp3PhXvLjIcWdu4qs4jA==
X-Received: by 2002:a05:690c:3606:b0:712:d7dd:e25a with SMTP id 00721157ae682-716590f7acfmr13770907b3.6.1751487293726;
        Wed, 02 Jul 2025 13:14:53 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:14:53 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [RFC PATCH v3 10/13] Docs/mm/damon/design: Document vaddr support for migrate_{hot,cold}
Date: Wed,  2 Jul 2025 15:13:33 -0500
Message-ID: <20250702201337.5780-11-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702201337.5780-1-bijan311@gmail.com>
References: <20250702201337.5780-1-bijan311@gmail.com>
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
2.43.5

