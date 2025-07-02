Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4072F7D15
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487269; cv=none; b=UJpgSMPjxbriZlLHkxxevfMKEkNy2bTZFZgxSKzjHJ7UZ3LzSEo+pU2kmv6XOvaPgba45zxAY8D2EhFS6/bu4tfuwvUMife4Jj8OHTOXaSJsLHsiSYfG+FbQRjIJQK3CPOqEQdC8WYrsJ6sR35aBUngCvJc5A/933vu2zIC7VwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487269; c=relaxed/simple;
	bh=u39v0zZeyjiQzeN38fl08Se0MVq9BWlAg6GHNyHASGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHqvWM5+zKQkDDjhnMbiHSwtfXEPw4c1GRWCpumhathgZrBQysy6+ci2mVoPvsqIkAbMnyoa+KpmlurehoCd32FSMaCeqhVhvL1ecFsfaVHD8BOZLiMGVwd4gZi2aWTFMaxNTEol5tghppKk3JCuBaZZhkr0dgAYZtB8EWJy8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwCPhRPV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwCPhRPV"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-710fd2d0372so2694557b3.0
        for <damon@lists.linux.dev>; Wed, 02 Jul 2025 13:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487267; x=1752092067; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lrqRfIbiznaxiPBqXSvk2Fj8kr9UwyfETV9qJL2pdI=;
        b=DwCPhRPVpX93s5qaDanDUPMQw9/Q37CTyUMMJ9hfyKlRUhK790z8FxSpTkv9VduJQF
         md/J3RRcaaQuHQf9785iXUiofgRIkHEF+5isu85hzMwTWrhEL+mfoLxS4LPlyAaCj833
         Iwzf50UmtlhLWgUaWZlgi/pYOGUbwiRhc/ABYTRbGRAkJXzlRYo5TcB/Tfgzo6JtQt6a
         LHrmHht9nPgW/vAmbk0MmoprCL+4/Qx0s29Omcv3K5ZBoUt/FwoTIUnolzoLubR/uXiw
         JSKUaZBm0shWzM83TU5PUFdISwYKcRSJVOusbjEPJGAFmHU84+rCRFhR329xu7ml/S8T
         awFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487267; x=1752092067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lrqRfIbiznaxiPBqXSvk2Fj8kr9UwyfETV9qJL2pdI=;
        b=La7ZM1fF6yY1EeJJRK/ucLD8gb3KOCDB2EADBtbGlGEZRajUxUPOPWnRUXbh9XvJNI
         YDdQ+/n0tKZF9MnuFMY7jckFbDRecjLmgrsCazhtknJtTw4qzoTao1AxZ5V03pXLlE7K
         1TQWVI+3SIIeKP2S8qzdDx6IsuwxSTD0CGBPHVz6ZY/k5II7cEquZcMhO62SDtVSHqGI
         NgJPtEGldAziLiBt5GY3lTAmMcwggDsa0hxNYUl3B/NPxjDZUvDpWazm9JEDsS/pen/n
         OZ6Cs1RBWKO4wjbTIC2Qf1a9A+QLKHNS6B9mXhqU2nOGfyP/eZl2vB1UW90yiTakBMi9
         MrbA==
X-Gm-Message-State: AOJu0Yy4uCCz8MZfHus7F0NO2QVZ1Izb38UEIZczkDKNbG2IaKTeYE7F
	9wcZdmQjCKhWk5lGWnpuU5PSZXenr/O1+LXwnQarIkcd5X5xaqj7e5IuqZR5zrEi5zk=
X-Gm-Gg: ASbGnctw0mIDpQ29fJfRlEvft9FftZZsSWmsu3j64qrL8V6nVwGL3Q2rYFEgpwxA1o0
	pIqU+jN2qSGDxnuerEOUilmNFO9xBoruI7iE5eyAnUi72/e02WmY1wJpx+bbltAcGKZaWChMmE4
	8EdFHV47XozaYjxE99/r8DQAbQRXSRj38+1GQ2nvzMe1Yvt1OxHuz7bQsi3Wg/A3iLiqZ6mY+55
	fu9AFZbgnSMvMN8NBMnsetc94Q/VFKCYjNV5VZsGX3U1nNOI0Qv3o3Y8G1JYc6z29SS21KYXEqL
	kLj8fCX+BhQTzOZaEHso3sjsHTDZ4sJ6xqjA1ahxsVYRdgfIoLrYVU1/UQK6Bpytp+cu5ZQscpT
	g7yY379E=
X-Google-Smtp-Source: AGHT+IGJzaqxYxk/z8axkYLbzkciZC3H6cDkoswua37kH/fx062ueaRa2kXVMDmpRDd/R39IV+DhUA==
X-Received: by 2002:a05:690c:6002:b0:703:b47a:7312 with SMTP id 00721157ae682-7165918c718mr14469857b3.15.1751487266879;
        Wed, 02 Jul 2025 13:14:26 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:14:26 -0700 (PDT)
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
	vtavarespetr@micron.com
Subject: [RFC PATCH v3 05/13] Docs/ABI/damon: document schemes dests directory
Date: Wed,  2 Jul 2025 15:13:28 -0500
Message-ID: <20250702201337.5780-6-bijan311@gmail.com>
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

From: SeongJae Park <sj@kernel.org>

Document the new DAMOS action destinations sysfs directories on ABI doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 5697ab154c1f..e98974dfac7a 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -431,6 +431,28 @@ Description:	Directory for DAMON operations set layer-handled DAMOS filters.
 		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
 		directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/nr_dests
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for setting action destinations of the scheme named
+		'0' to 'N-1' under the dests/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/<D>/id
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the id of
+		the DAMOS action destination.  For DAMOS_MIGRATE_{HOT,COLD}
+		actions, the destination node's node id can be written and
+		read.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/<D>/weight
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the weight
+		of the DAMOS action destination to select as the destination of
+		each action among the destinations.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.43.5

