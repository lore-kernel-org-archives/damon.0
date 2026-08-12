Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4F41D10D
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529094; cv=none; b=uVCDJ3oSks7G8fw8VuJEG2tnLP55sjFH9xP6XLTTuS56MX6mpDOf1kwGdjiZfGdfBiZBIWXxV4zRuI+gQbHkq80ZRfSboEIWyPJtEEKt4pYTBByOFE/rnANxNf7rmVaqV9mvug6bQSOn7HVzeTCVqnT6qatoZFZhwGOKF9KrjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529094; c=relaxed/simple;
	bh=FgV0EIRlXS2pNv/yLefwn1IDpSp+NZbkwedGH5rjvzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVmRGRFBxZVWGcMzP3mu9hanGsi1QmD2UxYNEdu6MH26YuV/9M2PmHF8x/yYe7cTvV9rY2D4v4TulMOFn6YpIxRqI0yot+YAr0yBDjbrMlkX+oreNWoOAwFtNhraLnx3+vDjuigdwG3shpNseQh4X7557BZ5EzCSqYA618HLJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnYRkKh/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnYRkKh/"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c96c92c0980so461729a12.3
        for <damon@lists.linux.dev>; Wed, 12 Aug 2026 03:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786529093; x=1787133893; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JxZo8B7n4c14lfP0ZG1amHyFP5yaEQUN0LvXnBt5yBg=;
        b=HnYRkKh/R1M03u58Nez2NqGq/0F+ySxIjZ/Q7Ef+JvYIpNUjSdw5cZWWubsRsQ1+Yf
         /Mdk1Fzk8QfFp/ww5y4bwFdR/hPbG0ozx8q7x1KcOadgdP2u1ap13DN1i1/abSMucNYK
         TyWn46h0+4IPtfzrej+LLULG6Cw5ITKluzUEqAbN58zBHP3JciVL/w9v5wsOsu5wMh/n
         vjOq0QteAASuqhZmLC0/7MAyPhYIZWXgWlfTZu1WpnlTbbFPFy1CFevzC0Q5CYPhTltN
         qtnZdZHDvQFxWlnStgXCGxpHG3tM5JxfkfDn/9OX5gVnJtIT7jhuN6t1snJXEgucpKv8
         jbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529093; x=1787133893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JxZo8B7n4c14lfP0ZG1amHyFP5yaEQUN0LvXnBt5yBg=;
        b=LKb/TFT7iYYp79TKf5Aq1iNwAEi5WGXGiAPp1N1Mls8S4cBqJseJz7S8elx5j2b/2W
         L+dBltmN6N1ZohEln4wd0BcibcAu6Gc4OG5HsXdW2kCLuB52JQXP49gYk/bEo/zm/63B
         Cals8Y/Vl85IujnaFpvCL+CigSxEKiVf32O0NLDoOWUwt+/R0aQtf0Fqd9CKKjIdDOYd
         qnqcSb0CUFxuJYVwJQh1jAW8Si+4IS1hC6co0DXEPxOGYxYE//3YGkuHysMtK69mlCEo
         782GKGLtYnQuZkk8RJlzyZTGHXwxLEIN3sAmkMUbnUVcS9ITXpq3ek73MDYeVqv0NZGa
         0xHg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1D2vBOGzFxUTnmz8F6JAMEU4dCBTPrqE34soaPSqwkpY0IvFRKWZS3SYQRkzFhiMJdgg0Tw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyARBx2YUXFsXEZmWCp6hpn2n0BPNfIclBi7/n3FgH7p7+uyBMN
	/egi9eQdedrgKTOYPxP85TxVrCmZ5bpOXFAgdB0ZL1pmeA/fB1lLSpwW
X-Gm-Gg: AR+sD11qT5cnxm5elMTj/NnKi2CnaLnKGJ+EpX/LzsnfFTJEP6/Asw79w0SaPNnWxax
	C4lsNFmpbnWdbW5fziVxqJ9eidDEBa3QxGuUedKPzQn9OOdNFxOWfKLeobXJJ+1OgGzbc/bVuJB
	9VsqaDikmgBQtNhgyoQ1cZ2p0Ta/RalIpct9CU8JWkfdSLck9VX7Bm6d1yJwhyMaaKY6H4/wbNj
	x18GoyKsg+KKpCRPNFlht/AQlrLOIn1rhwiCDEWefGll8TSAaqvXIAbmpn6kTDmYtxqLjUsIFgm
	vbZqdXf0eRLoZvkiJ1Uzd8LVPtwLc8OuXrS5TKXWvs9bLdbIYdQUNjkdX7Lsj4DpyUaCWKbBbED
	/HrB1AopADuvKQpyUW8/md24rVIkjj0r+CdTAdmshw6s5v6PPE9Et6jH1Sl/3y3Wb7Q99o85jch
	HlIeDn21AMuKs4y1GpeuG7PHmvAwCRX026EbLk4j5/lOZMBmDHtPqvWVDZYDK9eUpF0bNK3W9cT
	SIc1C4g6+T34Ac=
X-Received: by 2002:a05:6a21:4d07:b0:3c3:a20f:f729 with SMTP id adf61e73a8af0-3cc3f51e8camr4663363637.7.1786529092842;
        Wed, 12 Aug 2026 03:04:52 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14124454d3csm8821247c88.2.2026.08.12.03.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:04:52 -0700 (PDT)
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
Subject: [PATCH 2/3] docs/mm/damon/design: difference between watermarks and nr_snapshots
Date: Wed, 12 Aug 2026 18:04:32 +0800
Message-ID: <20260812100433.6288-3-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812100433.6288-1-aethernet65535@gmail.com>
References: <20260812100433.6288-1-aethernet65535@gmail.com>
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

