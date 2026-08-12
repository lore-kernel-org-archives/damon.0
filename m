Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64B78F3A
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531212; cv=none; b=rPiaNv/i9awF/6yhEKP9DNkYVmOSpat4Wo7NIe1i8VKMnwqnjb/Q9d96fEXSVSZzZL16R2nAEj7ol17pbmvEvhXPU58m9ihP9XGj1lmjzog/Pg9Fgiuo8068u4L6+yxmmW5+qREdaPLk1FdAfl2FXg2m1e32o+hXH+ycjwspLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531212; c=relaxed/simple;
	bh=FgV0EIRlXS2pNv/yLefwn1IDpSp+NZbkwedGH5rjvzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laWdrJGyAVnnX+5JPYAWwIIheFVIFl9OJRvTwogMIsGjsK34IKJJAgYtWSbAYqFYrnrOGaD5JbFcP7Mz6YL1QYni2qwOsb/YKxHILeGR0Hj0YRybRFRkoTOUlHYJNFkh1HOF2lGRAlW9Ck4gTzRIpx7/84mHsIVsPyj57VUeyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4xMjyZB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4xMjyZB"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so794545a91.0
        for <damon@lists.linux.dev>; Wed, 12 Aug 2026 03:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786531211; x=1787136011; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JxZo8B7n4c14lfP0ZG1amHyFP5yaEQUN0LvXnBt5yBg=;
        b=m4xMjyZBBltifzbdr6Yg1OsBPe/yKx0SKcCY4Qjtcx1q4/3mERENkH5nX0oH4yygx8
         w5NaF5DkPAtuClM4WJh66kkJahtPWA7Q2YSTrjxpNZhZd1xovb1k5XaK6Kqg6AbCUA7w
         a18Slu/SX/5dqDsaE+xYgmDzt290SQ2yC/9Er7LwgKzNAEjkgGTxB94BsFxKUVrHaNRQ
         S5G8OX61RsangK6rpcuM1YOZfZN8ckaJpIp0p3bPBvW9Ptf3p8e52KAo+nat/Gp2sdgD
         7Ru4AnGDj6shJ3cCGzcq2pVxarZTE7eGx11aIZRKaEEHYF28OOZ7ZNWQEYYtwX09EZBG
         j2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786531211; x=1787136011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JxZo8B7n4c14lfP0ZG1amHyFP5yaEQUN0LvXnBt5yBg=;
        b=XI+TA3E/+Oo9qnM9M68n729rDAfYT0SPpNRObge1S+vV3c7qiDHMAftcIDPz0rddKH
         3+r96O2ZNWvlfnzay2bH6rJNvIzLmYBSJ9DH/Ye1K6PQepoS2JTevirsAJytTwQyUbov
         rBoZaZYQwMNbh/r7kaJ8eUCo04UVIHH7keI8OAuo+MjPpa7dMnUUSWrx6Vx+1Ujle8Tu
         Kir6I+62rm+bDfwLfX53urr2/9slJWU674JqDc+ZB2vB2X0ZjODvbvmXWAcsXVwVDnbL
         pNxuyOXIPnc0s+AKpJgvChwhclj7GdtVFlAmqZtM51hKzlo+mrl7Dg/k+bNiyvzxbDJE
         jVBw==
X-Forwarded-Encrypted: i=1; AHgh+RpVLLRKEf+d7zn+SPGuvhgzb7kSIpLg6GU64jY3NfVzFm1ZP149gwB1cZYyMEXwk08TLfKOuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrnJn7QT6SgQ5xbUCoz/6/WsS6BLRWXqF1KAZWJe9aAWmdkn5M
	w9CQhRPia2czWBoBx71oS6S5C+aAcgLFcT0x6c0Aj18drhiMc7kXJzQp
X-Gm-Gg: AR+sD13OObCQ4+OUCk99wVOkzuLuLUXYXtnExBnLsE2cHHjYe/ln5nPQYhPzcUxVwID
	7pWhLsJYlxF7Eeg+2kYiHJwARPbR8Dl0sGJVTT13SMHUxgGobEQcx6YeHwNueJt3yEyeT5q7hyN
	EgCYW+qYmcE2GmQ36kxkmIanYQnMEMuSWP39tJ6lktB1SBwdcqfDTRGTzpeujyQt2y7sSqDLXGT
	v+4hrY4mBfPsKJBu2I7t63c/dmutgJrJ/qTrToeGN0WW1ep6lPy9QCmBcTzj1hFH+m0dhUn0a/E
	+cslia6svnR/ynJTcBxkScwcSV9r4cPIjcDpyyVmtSnj+2BmbApmUDWdCYD6jfuRnnzqJDRyVdh
	I7lCTYz8Z1mou0oxnSqPvGmAZ743KSCjzy5S/RPwZQXA0Li0AWbwaK5rt/EkCYHy0qI2FneN3L4
	ropVWasB/JpwRoBwruZHTGDErR1VBQqet6OmlkZMuF+L5tC8wyK/OB9eatC+EshUT6RTB8yO6Tl
	fQxXBXen5y3ye0=
X-Received: by 2002:a17:90b:3948:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-393014fa36emr4204547a91.10.1786531211043;
        Wed, 12 Aug 2026 03:40:11 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf3d0b432sm9931990eec.8.2026.08.12.03.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:40:10 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v2 2/3] docs/mm/damon/design: difference between watermarks and nr_snapshots
Date: Wed, 12 Aug 2026 18:40:01 +0800
Message-ID: <20260812104002.15225-3-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812104002.15225-1-aethernet65535@gmail.com>
References: <20260812104002.15225-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explain the difference between nr_snapshots reaches max_nr_snapshots and
watermarks.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 Documentation/mm/damon/design.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 939298f2a9b9..1fcf0b8c044b 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -872,7 +872,8 @@ the action to the region will fail.
 
 Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
 non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots``, the
-scheme is deactivated.
+scheme is deactivated.  Note that, unlike watermarks, even if a scheme's
+``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.
 
 To know how user-space can read the stats via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:s`stats <sysfs_stats>` part of the
-- 
2.55.0

