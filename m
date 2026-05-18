Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A9E38CFED
	for <damon@lists.linux.dev>; Mon, 18 May 2026 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131545; cv=none; b=dC8ar6woDjU2ox9/w/5VAfXxOUNFyKlSgsV3poaTam6M81ZCFsS+S3mheRqxF2p2iNhwGrUHZIPeezeMiP6NNbreFRmuwwhXsHCAHWimDb+Zfhh6G/aSqt2oKNbVYidojTuBjAUPqMZv3afQfYRw9a/mMrresMKyCFshrA3oA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131545; c=relaxed/simple;
	bh=+bngKoav4oRmKQXZqqtZhaGF91NFZUI89frNRe71ujg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uaYFL007w6nzmhP7hB0X9S1gr0PT2eccUhr3Vch3Q/SwziwQ2+49pU+A355tKl7y0dt2y4Zi0XC+/4WfmNB3LXqtj9ZYGciBYqlBLlaUNtEOOaFC9qlhLkIc2rxiSFeTAe8qFiTgR3Y9QWiVXP7oVUgElS6OVw90ZsbDZ3JifVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDATv5Qe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDATv5Qe"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so27549375e9.2
        for <damon@lists.linux.dev>; Mon, 18 May 2026 12:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131542; x=1779736342; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SInUWKhqXZ7NxtmtUcTjuIifSi8+lTWwUFzMJGjUoRA=;
        b=NDATv5Qe8crXO2u589pOwJgMmm0VRWhZ+GnyQiObzatcRJN+B4waVGyrMgdDtVifRd
         MaIColtadcCkn7DCVSChZ4EL/C+8lzRsfu6STQb+5Udr++F325Xdx47AE5Tgdqu7qoIT
         UXC8teA1DnJSTlovXvuOPQ0gMgEVnM/n/52H7CFSpNtly+mIta0Qyh6m9bPEoH3zAxVh
         r2+83ysGwBUcXA5Hk7TjeatJmcB1yBLAW80tzfpQkdxbpwihu9fZ6ymWsp0IKnXQNbqV
         DD8jDZXsxmNP2sAnwCPcWgj9g/CtKvcHq2Am8RVqRYJ1XGE2iwoY2h3ay6sl0tfhdsiJ
         5pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131542; x=1779736342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SInUWKhqXZ7NxtmtUcTjuIifSi8+lTWwUFzMJGjUoRA=;
        b=Jc53qzA8GuFgCD2iqtmi91ekUfI4maGSVgUzKpW2gT8Q5e5fPWZgLjonuxt8m0mjcd
         DX2IPUXyyS1xVKaPSGMTtxRm+zps/UYXgrhBsfQliZavrvwkVeddWpOLUP5OLEKJ7xys
         wGsb7vn0Ur3xLWVWXgnAlpMfrNXJXfI1B5oMODngI2tWsXqJFKqtzdtp3UTSbFcgho4C
         PLMmRGpTumWq4t30IrtBfZ2DMhMZ5jCnC4ehvX6ZTJ5j5agSR2dD+ueItP6vnrEOr7aU
         3ubiOG3LK3uP2dfZ/M5Q6rgL/aNIeJ4GLkrU8GCCmmdpdyiyyuK6tO6C0xas6h8izDGi
         /mQg==
X-Forwarded-Encrypted: i=1; AFNElJ/pXjgn7bApmJUe6HEQgNSJ/lnMLNd/hSYrcu6QIEwizt0psY1UArIeYAgPHlziYwjnxhLaOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyebU+3/N/udBL+htd6He327QSLHqIgT7O9ViFqqAvJOlDF9XDL
	fL4Em87X2yOBEGHK+88lVctQXb3zNUAxprLrLPAQIj6K3jjNenP5VsV4
X-Gm-Gg: Acq92OG/GBOlDx3ap/xnhRbXyWsNT6ki8bCWEW2rUvFKLOK7IvG7iAMRJpvmts9rX51
	iyQ3fG1v+XqtalXU3E6fzFMXsTnlTpSe9F9Zr4mFL8WO5/soHnWC6A2ftZ9wtJiiAG4zISp4DTq
	1tRuf/knjKnI5Y4L2ThCGHuGTuG9a/xquui7Gvdkoqpb3epi0ffrz9MQR7/9fQ6B7DLCoeAHsqk
	uVhIhhT2eMYEyU1omAN2CAlyw0JYvM6JVO7yjZi5ATa7+ewCWjJzLaWRcCQbEo+5S4gzzyxUIs9
	UGks/Yf5yh48ycgTPwiOsw6cRzKqbPW5R9fxigTyiq3vs4Qbbhkr4Fu/X5s5n4BIfzyYX05NuR1
	Da1pcrGeNGnb+iyZfSUKaMZ2YnLj68cmk9ytFeEux+3qegdLRX40ypX7yF0CEu/Xku6a2yRgX+X
	p9g3CA1LxhcLDPLRU1leqsJcA8UnaMNCUeaWwOA1Sr4IRrU5IqIBs=
X-Received: by 2002:a05:600c:4e47:b0:48e:707f:cdfd with SMTP id 5b1f17b1804b1-48fe60e54f4mr274314295e9.2.1779131542277;
        Mon, 18 May 2026 12:12:22 -0700 (PDT)
Received: from mshcherba-RedmiBook-16.. ([188.163.115.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm40043167f8f.34.2026.05.18.12.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:12:22 -0700 (PDT)
From: Maksym Shcherba <mshcherba2000@gmail.com>
X-Google-Original-From: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
Subject: [PATCH 4/6] Docs/admin-guide/mm/damon/usage: document update_schemes_quota_goals sysfs command
Date: Mon, 18 May 2026 22:09:30 +0300
Message-Id: <20260518190932.42270-4-maksym.shcherba@lnu.edu.ua>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
References: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the DAMON sysfs usage document to describe the newly
added update_schemes_quota_goals command, which allows users to read the
current values of the quota goals after explicitly triggering an update.

Assisted-by: Antigravity:Gemini-3.1-Pro
Signed-off-by: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
---
 Documentation/admin-guide/mm/damon/usage.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 11c75a598393..097d8ebe960b 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -167,6 +167,9 @@ Users can write below commands for the kdamond to the ``state`` file.
 - ``update_schemes_effective_quotas``: Update the contents of
   ``effective_bytes`` files for each DAMON-based operation scheme of the
   kdamond.  For more details, refer to :ref:`quotas directory <sysfs_quotas>`.
+- ``update_schemes_quota_goals``: Update the contents of ``current_value`` files
+  for each DAMON-based operation scheme quota goal of the kdamond.  For more
+  details, refer to :ref:`goals directory <sysfs_schemes_quota_goals>`.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
@@ -448,7 +451,11 @@ get the five parameters for the quota auto-tuning goals that specified on the
 :ref:`design doc <damon_design_damos_quotas_auto_tuning>` by writing to and
 reading from each of the files.  Note that users should further write
 ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
-directory <sysfs_kdamond>` to pass the feedback to DAMON.
+directory <sysfs_kdamond>` to pass the feedback to DAMON.  The
+``current_value`` file is not updated in real time, so users should ask DAMON
+sysfs interface to periodically update it using ``refresh_ms``, or do a one time
+update by writing a special keyword, ``update_schemes_quota_goals`` to the
+relevant ``kdamonds/<N>/state`` file.
 
 .. _sysfs_watermarks:
 
-- 
2.43.0

