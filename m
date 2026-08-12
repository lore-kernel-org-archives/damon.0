Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FB4279FE
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531207; cv=none; b=cezR1yK5xENn6NyqA2cD4Wc2dJbasNmK2igOlGxKYYhNeJpJ0zx+uGqX3u3Kxx42LcynXxDk5gfvCArMIphI/9J2wQhY6QBcTGvCT12NDsly/Rz7s14Z+W9mZxqWf0/LMuwqVsQWsRppcDJXEm1ONt99qj7OJg298uJqUnSycpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531207; c=relaxed/simple;
	bh=eK0hHCh+yZzclf4rIm6IurXoL5Ts7SzxFMQTEK3zrDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqwDGTcL56rjS3Cxu4g17pyewx6CTWppQgH1/0B2QSzngpUuoUT6y5eduNpKsEYOvltdNXpsEhdcpb54gu6LPEnhWRL8ThhLw0z87S/46Kx7zDR3J9N0gFZ4hKYVCVXd3gLpacrMuoqaN805EUrlKagz8U33T8wWBCh55u2PeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otDaUmNn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otDaUmNn"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1126503a91.3
        for <damon@lists.linux.dev>; Wed, 12 Aug 2026 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786531205; x=1787136005; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CySejvRkZl+O/T2betXJvXb5NuBv/ihH/Yp2vgUVu+0=;
        b=otDaUmNnEjC7x1zViKLYgzjvHzUHnQkXNQ4gSFOcNNN3duyTciEhX7K40e4S/qUfqI
         56tSb1IvXRAC1TRHwQsiWZRxxLKBbU4hJTwfTjew6Ui0WM4hUKB47k7kjGM6SU5+Iulh
         9reSnEYpW+bAvJHJYw+XBWjyLrLoc0j0Ar8U40DHEWKKlKbm0uv8jM6NetqG7HT/0G0j
         DiSZSz/GCgo64GULprvlZ6n4t9jlHl4EnS0TXArep0ls5Oy6b0FSn/CXkPe8WkT32Pkq
         SptJzXbUvtjGhFmmHRAPhte4fTNoBS5FW1C0JFnw7fpw9Jvk4DZ/KnYlEhzUBj3ZM7YH
         TD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786531205; x=1787136005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CySejvRkZl+O/T2betXJvXb5NuBv/ihH/Yp2vgUVu+0=;
        b=hKLUjhSJnhn/lpA7zJIBa2jtddI72LJpmY4lDVaQv24fQbV4HZYfyy8koc2aR8Xa1r
         f8SdzxysEXMa5Uwmdnu9p0w7KO2SupRhM3lNUaUFt2c3lLGBvf8s8cQazrcDw4VG/CrP
         kpH1rW2PVL1LMOO2rxpTRGuLV22eiMngj91fp9RSIMLcloaEACuiXdHqdLjhfMmdOg+k
         MGF0saip+r9ck8rv9W7puNoQjH2wOcrmL+Nt61AN5lc1ZZno+fy5RdymPnGvYf5AAlfu
         ooP9iFaaWOBVJq6BXLgHOLNWv7OWUWrMXEaASK7dOFvJs1dFV3wdSTxFHZAdvTEGCtrm
         MOZA==
X-Forwarded-Encrypted: i=1; AHgh+RpY2S5m5pb94leg4IrKjt5IyOKYCA3jm0Iq5J6IYR3RcjwMFkiKZ2cPoWdsopodl2T6UJHvpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIAuiDVFJCdZA947945SQu/ZMdYVL960pMZGAJF6JaT8wNiV+H
	VLH9BhhsggIbz4olqeXSzgIgDvvkDArjz+WX9lBFLcgl3KkfKrYrkXhY
X-Gm-Gg: AR+sD10PWRzy1alxlSead/omB96N5HMGWzkrmF1Imn2QOBXVoCa/nwP7QtP1w5VvCEs
	pp8MSf+CPEDZwUnZ5qKSh9HpdWYQt+kWxUaK5xYbgeGcusU9tAh7jG5Qjv8UCBunfo63JLEiEX6
	+B67/T6aVO57Pc2KfZMPe/mT1X/HT4+niQT4SG7BMP0sYNACETLShmK2/6h+R08iDE7IWTL6Efe
	vQEercHpR4WAERI8VDwqVS5/mutKLmkYcMTS3118MfFjMtx4XMZN5HHDEpXIL44Md7mIlVsg2tl
	KXcuxpSOVKX5J9yNMixCSDpy0RUwD1hQ4owOvAwfEjU3RcpftdrBUkvCUfeEihd/rloRi41FG4Q
	0jF1MgO+/2AyCLzcy6A/75x2os1vIj52XJugdDfNnPG8D5KuXyDuJaw7Hl3Aa/56i1wIKjYJSrX
	TZpGpb67E5YZ3wvV7+sQu/w6/RwIwS9gDlDfAtd2GU7B/mvHQNXAhk0EO22EdvrCui1r44e4QLt
	4xEYDcymE8UcGc=
X-Received: by 2002:a17:90b:398c:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-39301433f18mr3789699a91.14.1786531205162;
        Wed, 12 Aug 2026 03:40:05 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf3d0b432sm9931990eec.8.2026.08.12.03.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:40:04 -0700 (PDT)
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
Subject: [PATCH v2 1/3] docs/mm/damon/design: accurate semantics of nr_snapshots
Date: Wed, 12 Aug 2026 18:40:00 +0800
Message-ID: <20260812104002.15225-2-aethernet65535@gmail.com>
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

Change "tried to be applied" -> "completely tried to be applied" to
maintain consistency between the documentation and the code.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 Documentation/mm/damon/design.rst | 4 ++--
 include/linux/damon.h             | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aed6cb1cf483..1739aeec6eb9 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -846,8 +846,8 @@ scheme's execution.
 - ``nr_applied``: Total number of regions that the scheme is applied.
 - ``sz_applied``: Total size of regions that the scheme is applied.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
-- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is tried to
-  be applied.
+- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is
+  completely tried to be applied.
 - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
 
 "A scheme is tried to be applied to a region" means DAMOS core logic determined
diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c8b7ddef9ab..33914594fb48 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -357,7 +357,8 @@ struct damos_watermarks {
  *		Total bytes that passed ops layer-handled DAMOS filters.
  * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
  * @nr_snapshots:
- *		Total number of DAMON snapshots that the scheme has tried.
+ *		Total number of DAMON snapshots that the scheme is completely
+ *		tried to be applied.
  *
  * "Tried an action to a region" in this context means the DAMOS core logic
  * determined the region as eligible to apply the action.  The access pattern
-- 
2.55.0

