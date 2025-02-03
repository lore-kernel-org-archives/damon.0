Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC51FFC71
	for <damon@lists.linux.dev>; Mon,  3 Feb 2025 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623386; cv=none; b=Gatxu68MkHAdUgwugOGaZsUsIdGtTTzuFjQUwVKxLot6ot4gSWbVjyDCS6OQ5P1j6dMFVDDsxX4uQFlkwDIk5mZ9GqxZa55wqrLyZaaQEAW9SD2M461ldmX8WWECvcS0P0TXm7C+gikX8jIu96iSjZ/S2Pn3/PEVkGzezSx/vnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623386; c=relaxed/simple;
	bh=tk69ldXP2TuyY1ADPUc6ZzOFs4ZjTZmPQkePfvFToHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1fT3rgZ4V1cPGCh6LYZwnvEDnPBp2SSBSWyL15K2ipT/A9XbewBy56k+q9hQUdbLBQCKxj81uCyVorUOTmFQe82FGMENpqsnpzsC4rMwOYa65DnGsa0L6O1aVX3+lZYfNNcpfZ3MAhChwvmog2QvbXcgt4BX7CD1cFnUSzozIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrrrMIDP; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrrrMIDP"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8e773ad77so37767516d6.2
        for <damon@lists.linux.dev>; Mon, 03 Feb 2025 14:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738623383; x=1739228183; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2enSL3C/soI5+mxHJevUzCK3eKf+SVmFvEq416WsAY=;
        b=JrrrMIDPxt4KL7E9RKnSQViyI8ZuCl+z2q9c/0Lz+pwJh6MSmWEuU5HfC5HlGVi9T+
         RdD5kLho67/qV/FrD0y7fx614ZM+KHivuYux5uTek13Jz2nri7n9LX9J2CNDnrVt1XIR
         BAHnjyEJ/WD+U2/rKgTKBSeY6SWIcKXTpMbKdzvZDeOl250gPysiIuVzpHoIbANA/hLv
         tka/WUWhGHaUxKXwqG2qXjtUJRKlpknk3f2cq7QrzovLZ5BCmc+yKqmhCGCsVEe8Evua
         QDoPh6GhcJUDBwbSkGPNMbK4tZeGQPZGtVpsvJnPyAk34Lqz87NSDsp1pM2/Qxi38rNZ
         WA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623383; x=1739228183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2enSL3C/soI5+mxHJevUzCK3eKf+SVmFvEq416WsAY=;
        b=QfCiuWfzSY4nxp6VDfDcBiReZrjapg8UpnZHoPJfxXKyyx2JNBxprUFMt6PCVwiitN
         9HWB6OW416kMEOuoELK5Baqx04CT9i84qs811UirUG+/83lAHcEhzoypp3jXnPDNTRcs
         0A0AqtRijtear+E/LzE0iYmUTEiwcZJ9Tpcdi7nOW05k6BcZ+l7YdZJ5e6nWiAKQh9Z5
         1n5dT9MD4FTzeZ6/PsbApJADrB2qAFyeYqvOKiH8ehU+V9+UJhj7h3fYUDhTi8ou24El
         F/ridICWNV+9PHGVbt2O/Ke8SAaPDAwlqf5UWthOJco3EhjrF98mHIPIIjX212Q842Pr
         nYEQ==
X-Gm-Message-State: AOJu0Ywu3O5WW64koYBHaGT0nqw72btjpECIai0EJuqO5xnXPSLFwBw1
	bbUJbwCYnCGMUXbEFMStxNrFj5Jb0VtbQh2Qv7rrsydV8KgxnuTc
X-Gm-Gg: ASbGncsnFKLkreEqSTv1pL2MzsaqUShjG+pQiOsZq2HQH25keDr0g0M6Eks1c40E4DV
	NTCuz799EECVU7s5G2MOv5sMsS0ZGW7Ri+C2OeS4smS0SXe9ta2YKVAJOlmHCsXinFXIgG9EGqM
	v2ctnaGJg0vB7dxd0tWu2LS8L64FgikZbxg+WsFutpGt2ejkMS2JHGMHFtEoHVGULe3sbgJ6pOe
	Jq+q3m5+HBJr6NB/zDJq222KkpUUL+K9OmiPZh00EkFADuGLhWGVoTTM0gPlKpejj2OjAFcnuGM
	wdNagvQ1epku
X-Google-Smtp-Source: AGHT+IEK74qRw53aqOQPEz3F2ZyQP/xCGiDZZ/sr+Au0v3csysI3ea4/+VxPaAXJWM4NpzHFVT6edA==
X-Received: by 2002:a05:6214:5d87:b0:6d8:a5da:3aba with SMTP id 6a1803df08f44-6e243c3b07amr339051006d6.20.1738623383619;
        Mon, 03 Feb 2025 14:56:23 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:2::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46ff30fc6fesm38009861cf.27.2025.02.03.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:56:22 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 5/6] Docs/ABI/damon: document DAMOS sysfs files to set the min/max folio_size
Date: Mon,  3 Feb 2025 22:55:32 +0000
Message-ID: <20250203225604.44742-6-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250203225604.44742-1-usamaarif642@gmail.com>
References: <20250203225604.44742-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used to decide the min and max folio size to operate on
for pa_stat.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index b057eddefbfc..07daaae3dd16 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -345,6 +345,18 @@ Description:	If 'addr' is written to the 'type' file, writing to or reading
 		from this file sets or gets the end address of the address
 		range for the filter.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/min
+Date:		Jan 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'hugepage' is written to the 'type' file, writing to or reading
+		from this file sets or gets the minimum size of the hugepage for the filter.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/max
+Date:		Jan 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'hugepage' is written to the 'type' file, writing to or reading
+		from this file sets or gets the maximum size of the hugepage for the filter.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/target_idx
 Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.43.5

