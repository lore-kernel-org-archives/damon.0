Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1F29344F
	for <damon@lists.linux.dev>; Tue,  5 Aug 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410866; cv=none; b=mf8kmFD+3pvOAprB5FK9059mtF9gHlNsUy1YvGG4LqXDunNjZgT/ofkKaHF/KINUsJHX1C7m6SB3Rcfvlg7k9dotFEgvA6H3Wn8aqExpt0uQGDh9tkjdxW4CSp2reKLfKYFRPeFLsr7Xhv6UA2upCILzVHTmCp5iWiyMxUGxXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410866; c=relaxed/simple;
	bh=sRiz1J40qM7F1f5zbR2yuHtbqdCjGQCfPAToa5nzbY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrlqNgCKx3x3uO2ty46p1KAhmdZ8vt9PfthXEeYrdU8uK+CWTNcjxVWgPXylyLJTu9RnZaH4BIEw0rQdP6sr+YzmIZZCD6MD9c++5vvphPv30VfR2XfMTbCMqQEfuso7ut5DILGUjjQjZWdooPZd3QBUiPq/fiH7WJBVZKDfWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqEDhRBq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqEDhRBq"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71a38e35674so27802417b3.3
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410863; x=1755015663; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjNpkvSXW+v2m5Yu69UUOTo/LokqTIxoGaybS6E7Cys=;
        b=mqEDhRBq25M5WRz+o9SmfNhsMuGNfqVFMeBhZIal6affLlSLiWT/onASIw7jWEnQ4S
         IzG4sbFXV6z6JDajInV6Jt0kBkQqqnBRn1wu6L0A/CidRbfk2pk1GLhegZ/kf6gQrMlo
         242vwdViuDsci1EuKx/GDPqoTPsSFl80d3NmdmLMKNCOoS5bkxwjFINwoo/s3JtkBcTj
         YpBEjeGBe63FmH6JWs7JkldY5YoJgxWoj4sllR9H3ZfStnO5NsVvE3Tk2clCmwOSUv4c
         CJzJNY8uFsctkehKtqOrCLSBKAGrOS0nlT8f5+Ir8BYeuCA53M3ShvzEwUGnVjPfqmfH
         BbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410863; x=1755015663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjNpkvSXW+v2m5Yu69UUOTo/LokqTIxoGaybS6E7Cys=;
        b=ikvKGsanZx/2pb5QwwhQhlwiR68/289rJ+sLVdejmH4AunBzOzolnrRcHlRYiXLye8
         KDkTBQfhSTWMKndHlhyMGOmI12QgjBNbtA+A0kRBIIdHBDR9UxuIKLT06XetxEI4qJoa
         vs0C1zkHsLq4+M5xY3+0X6w00Jlb8TnygAEC6uUxAv92fSqd8upT418RhGMgJdKKt2lA
         ubFBTcbxmRV5slpOBMosPU8SnvMq7YwHGAAiDAnP9F/dQs4aDEFiqXtn/TUGoAbIhjF9
         USafSQL6s63OUWjKfA0rXEzbK77aTgXOjt1bxvjyFSFveGa52SP5QXF19BaPQmCeWfTm
         sKTA==
X-Gm-Message-State: AOJu0YwAWwYgOW/+2/cmXp26IreU28ykLLq9sO1MEomje9zJdxuv4VEy
	JmFajvZK2I84zA5Co7irpIEtiTqq2TfPqJTc/eJWiB0r+z3m0/O+RIH0UYLugg==
X-Gm-Gg: ASbGnctziOHVMztndw0zqR5HSo9Qn5MHl5C8NQtA/dAcYV8tFJZNh9NS93hoXs/eevj
	78NP7sqWEU8S0tHeUYy+iHRSQBzFtnj2J6Uo4wos38YjzTDLUp82xAhw0FAWnE97sYXQv0cdO2L
	JxePQcoho1gBQEVATmb5eQVdX5abHSz3Yrfir3lqPGek7Qu9UENQVWxk+olj135KMOIYuWpBI76
	Om++ybwN25rOMQiBAzN0Q3HQWYLP2oODqAo7D0sFce/ddIsLydCQvt4YZkTrADu3dzrHyc6x++U
	vwvspkjNTn69RBu8hnQPdI/2WwpEEEPJpzE5BBvjZjgrFtYSstB8OiW8ANrUQYU2QIX/bpPZa/S
	lZp4Zy3mQ/kFPM8m2wnvFp0cA2gc0vpVgLzkvyIBXjGw=
X-Google-Smtp-Source: AGHT+IEQM0QlTGhxyMPibEvEMDpbAzpmE9uEnXqB1fB3pRbIadxeRKgx9pmHX+QFoHCpre2n2PEesg==
X-Received: by 2002:a05:690c:8694:10b0:71a:34c6:706 with SMTP id 00721157ae682-71b7ed8b056mr123189357b3.17.1754410863480;
        Tue, 05 Aug 2025 09:21:03 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:21:02 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 4/5] Docs/ABI/damon: Document new DAMON commands
Date: Tue,  5 Aug 2025 11:20:21 -0500
Message-ID: <20250805162022.4920-5-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805162022.4920-1-bijan311@gmail.com>
References: <20250805162022.4920-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

Document the new commit_schemes_dests and wait_for_schemes_apply DAMON
commands.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index e98974dfac7a..429947de9aba 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -27,16 +27,19 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		makes the kdamond reads the user inputs in the sysfs files
 		except 'state' again.  Writing 'commit_schemes_quota_goals' to
 		this file makes the kdamond reads the quota goal files again.
-		Writing 'update_schemes_stats' to the file updates contents of
-		schemes stats files of the kdamond.  Writing
-		'update_schemes_tried_regions' to the file updates contents of
-		'tried_regions' directory of every scheme directory of this
-		kdamond.  Writing 'update_schemes_tried_bytes' to the file
-		updates only '.../tried_regions/total_bytes' files of this
-		kdamond.  Writing 'clear_schemes_tried_regions' to the file
-		removes contents of the 'tried_regions' directory.  Writing
+		Writing 'commit_schemes_dests' to this file makes the kdamond
+		read the dests files again. Writing 'update_schemes_stats' to
+		the file updates contents of schemes stats files of the
+		kdamond.  Writing 'update_schemes_tried_regions' to the file
+		updates contents of 'tried_regions' directory of every scheme
+		directory of this kdamond.  Writing 'update_schemes_tried_bytes'
+		to the file updates only '.../tried_regions/total_bytes' files
+		of this kdamond.  Writing 'clear_schemes_tried_regions' to the
+		file removes contents of the 'tried_regions' directory.  Writing
 		'update_schemes_effective_quotas' to the file updates
-		'.../quotas/effective_bytes' files of this kdamond.
+		'.../quotas/effective_bytes' files of this kdamond. Writing
+		'wait_for_schemes_apply' to the file does nothing but wait until
+		the next time every scheme is applied.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
-- 
2.43.5

