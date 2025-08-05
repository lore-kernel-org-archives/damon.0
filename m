Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616729899A
	for <damon@lists.linux.dev>; Tue,  5 Aug 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410870; cv=none; b=PxNQdNDG8c0YpdTnIANK6NO5UKrdOXCNVclsjtneEcrhjtkasSWf1H6TLSVR6uC08jGzzit+vI9t6p1Symy2ULzrWiNYpWqrBWGJ6HR7UZamo0B2VIlQMswZ5hKmlUhuKas1y72gIAhChykO6C5sU+6dPRHckDm5D/G6H53f0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410870; c=relaxed/simple;
	bh=5O6p11q/Cm+Ve3FqC6ad3rDEA993jGbgYys+cf11XNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5o4tAzMgmtkBshHJE7+OuFg5jqokDRA3zE4i11QZwtPgFSk/4WXt+YfHHudpafba2ednXOqQwGyA0DVo8uXOTyLhu9BfeIMTB6uumxheWKKS1N0+11rcdEWBOZ/9g2PnzY2dZP3sj74ll4hNahgxGFM2P4GIWGjoP71vWkU1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU/wRLhR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU/wRLhR"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71a3f7f0addso54026077b3.2
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410868; x=1755015668; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2I8Y6YCxsX4TWyWrlqz+OvW3M3f6/2nWl2bm4+fH+c=;
        b=FU/wRLhRB7t1rkduc+wG5II9Ie+GfVRwR4PrZLPYV+m02cLynpN8RopDZWCKyw3HK4
         OucKXScVOW+QegTVSBCBLDjh9dcv1uxgjHqQD44/E0DD0liAtz9KM8Eh3PSOMxhjxzCo
         RPClU4rJmJ2kbTwOxmO2PxlSeLSilee3Pk4B3I2kG3TfWmFmCSrZhI6CR475oKnHvhvs
         cP6OhNB6x2xlMusLOmZwcA8eVrXDEMjBA3wmmOYMThdkqGTVJHD/9mcg3juhZy0GQrVi
         64cDOy+kBvIS++jILjkxRg0LApQXXLO0rbK6zPUc0cSbi8CPzPYOsAP9uQItVJ4HWm8L
         7pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410868; x=1755015668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2I8Y6YCxsX4TWyWrlqz+OvW3M3f6/2nWl2bm4+fH+c=;
        b=J9W8rr/sioSRGYKmgltyCMxt6S/ruzxyz1B1wFJccCABk9K/nssJgC0dInNdkuUBNw
         HT5aqRvop2sc0MUU12f2RRwVxHFY5wHK9gRF6ayLYvC69jtpZfGuisXAGpw60IuY2Oji
         Ee4LDkFn+/WroPDZtxdaokFFVL5HWoImrmTrb03VtIFolWtfQ81/Scfn2x/QKHB7Gcku
         8d8pG6gkocFK0dcSOCtnDOzj80GnFCLnses3dMLdkPQlk7wWn1B04odWd2JsVZdJjBN8
         y3LzUaaV+F+7uLaXwxDvwsZCBKVGENs+0T28QMVWv3oywUhymA12sEhuKVpBioWLkQDB
         XjiQ==
X-Gm-Message-State: AOJu0YzadBlyEM+TedE9bS5vqlsRGfehDaPv4tVK3O1svWOsKBg3UdSR
	jOZS+u+xzhPmZ+vhzAG5wcdon2ZJJDwBea8tJAvePVt36B6JEKLZg0rpqCGQlg==
X-Gm-Gg: ASbGnctxtwfGA+r3kmFl3oghu6h4rLUENo4fUVTMBXBa6FvvnZC1fwmPGuk2pqp5Nz9
	x7aKERH0Ql9/VWwG9lYH9fP3g+NWWFEAmRKEU1mgj+TrlyRwrGQyBnt9ebBr8R2VHXm43jpUPgy
	zVFh4jAlorkBIIFCAyawZYsrXh9ld6zeTqhqfumRCC+vrdWH9zMjsE7475SisgDOaAsZWCrcqDs
	tPRR716jl/JmoTm9e+XaJt4TRerSnpQjIVEDv0vAF8Kq4ppLS6+TKyZTQDwUXrftL4JUygqgBjg
	F5jlGA/YcqU601fBFpIdXhNMQS1weB8VOv/CpikthenfnNHNZtyR/V8p3hD71F5r/bCorq/8pMf
	dfRoKD7L3Ov2x4P0GIRzx3lN9rWFq5RRQTUgkAxuIRZk=
X-Google-Smtp-Source: AGHT+IGS4lh1JrnZOMCC7QWGY68gCUxCM5gOUlyEM6e/iXESyuVJbUue1PFdHnmYU2Ldv5Xe1WJeww==
X-Received: by 2002:a05:690c:7107:b0:719:a34b:5e50 with SMTP id 00721157ae682-71b7f5950d2mr163236987b3.21.1754410867586;
        Tue, 05 Aug 2025 09:21:07 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:21:07 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 5/5] Docs/admin-guide/mm/damon/usage: Document new DAMON commands
Date: Tue,  5 Aug 2025 11:20:22 -0500
Message-ID: <20250805162022.4920-6-bijan311@gmail.com>
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
 Documentation/admin-guide/mm/damon/usage.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index fc5c962353ed..46b6260855d9 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -142,6 +142,8 @@ Users can write below commands for the kdamond to the ``state`` file.
   for more details.
 - ``commit_schemes_quota_goals``: Read the DAMON-based operation schemes'
   :ref:`quota goals <sysfs_schemes_quota_goals>`.
+- ``commit_schemes_dests``: Read the DAMON-based operation schemes'
+  :ref:`migration dests <damon_sysfs_dests>`.
 - ``update_schemes_stats``: Update the contents of stats files for each
   DAMON-based operation scheme of the kdamond.  For details of the stats,
   please refer to :ref:`stats section <sysfs_schemes_stats>`.
@@ -158,6 +160,8 @@ Users can write below commands for the kdamond to the ``state`` file.
 - ``update_schemes_effective_quotas``: Update the contents of
   ``effective_bytes`` files for each DAMON-based operation scheme of the
   kdamond.  For more details, refer to :ref:`quotas directory <sysfs_quotas>`.
+- ``wait_for_schemes_apply``: Wait until the next time every scheme has been
+  applied.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
-- 
2.43.5

