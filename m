Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22138BF97
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789802013; cv=none; b=X06SmUpByi/Y6RGAbEr6x3zZ6L/llxAkQ3kKufbDQdDN7VTOi7AdrqRApVqc410rOp+TKMPAE4U6Kwbb0fXAWYnm4cpYFGwP6yNjH204TpGV5aEIVi4gbxWXeZRynpGBfbmniAzEtOUDrPGx3LkDn3xSyMjEOqjMWDIOe3IKElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789802013; c=relaxed/simple;
	bh=OpyRyDHgKlqaVr/FBHAfpdJLf6Saz6hZoz1PafSpOOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyLoNUmQn6xzP+0FZo45lNQLP3yIv36N/NSEVcf6txxLoUziG2mNN9bJ8KGQQlyUpxLGOH4YKN793ecNVkEdeCGExq54EkImPMiz1ltmRuwCQTegoJuRi9WcBkxcL5kGF1BzsCcgzHvkJrSbUJxFIRbAF6mzt5mX3uZsNLLZQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z69jGRGL; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z69jGRGL"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc52bd91929so1094841a12.2
        for <damon@lists.linux.dev>; Sat, 19 Sep 2026 00:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789802011; x=1790406811; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AwQsFaaF5KGdcLtlg+j+YQG7OiHlq2IqvQxHexSosrw=;
        b=Z69jGRGLNIW2BG4GbpdR9AqXbsxrpmYLiIGRSZe5DkyxqNKASoS8xJ1TKTY7OQ6k22
         8J3/ZkGF5IKX7sdb5MyBpVqusx6iCdjg2Ee5LXp9113ECEb5TCUAtXvU86tRvMek2VCA
         N6nQhevhWETrmHI12y/5qJy/Kr8qeRUy14h81ipmEdVP7Lxe2BP+2F2jW+pHMpsFWwPE
         egr7fp1ul0Tlsg61nVbc1dSm7fP2O6OnKvjNg5Rhm0M7Y2nNuKPWCc+cU0YUGuaSNiO7
         jDFSvaRhnUBnqL5bP+Lwkf27LZvO5ahTPQCPDUm6qvBU8GB89Kmooadx9XbqNO7QpK0g
         Pe9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789802011; x=1790406811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AwQsFaaF5KGdcLtlg+j+YQG7OiHlq2IqvQxHexSosrw=;
        b=RvHNE1Ao0iX5jxEnqDyy0lL6ZMB9HOyvhsOEjseVFDPf9SCnvfjNTaBTfbCknkhspC
         bYt0D6bVExada8rffFxuafiC4Z1KoquPL3p9KKu//yhF+vMrmyJWM0EYGsl9MEv+U9Uj
         FuzxR88S9EiQWL5MTE1simyBHtzdw7TcZskrJNnclSwe2+UUJD+HpMHEXIjRMb9RLk9f
         shCgZx03y6dvFA/N32K36MmdyWVppGZ+K3PVmqJJFK08HilbmX4Z8y8W/cy+sYLsDUl/
         QL8qqumwsK/yv9jDUTER9e9ZSA/u/yyA7pTpT4Uy7HtXCqS6vO9Vz547SNO76acYNXh5
         MA4g==
X-Gm-Message-State: AFuF++nUGGCG7lCbA1UiDBvF/Voqh9hI90T5RiUlfjzfNS7bH64mcWgd
	80kH4BPQ2p0yeIeyHQdOkSlZDp4n3j4dtRZP+Y8inI/4aMsoLp3Q/Os=
X-Gm-Gg: AYBFou3bHGG4ogGXN6OfNDcZKjtmWVIAw+TTnYBDgH5qNGAhaXonRlE9L5Pscc2O2ML
	NaFpMPaO1Ux2J1NOXchfDejYjmnkKZULzX4bJ+sVxAv6dytmguY2bh6oavO77fwgtptcrXsRohP
	TbJ41zdxpewnCAns5VmdzGl44pGDyaP1c5AuUR9IGhleGyD3tWrEUbvLKGgweQLthX4EgbUV+ey
	pvMiMRQ18S3KfKen79nAg5pE+/MgJ7iOc0AzXt/vfinAbb5kRJMxBZuCZlldhOnVH3X+TH6wq85
	5MY26EPMbhbmLxrFJS9X4r0JcbuSnIrSqAnJER9pL5Br37pvS6K4mBzeyHAd4krvNEQYkopDqJC
	dbTB7m+XsS+3VBDb/jtFHURWeONol/nfOurWixjFpdTt8IpDHPUM3zHezsawH+Y2DeoWyEpB8cg
	TetvDaBdl9LZ4O8bTj6zBgquc3ccDRydtaWnmsm254c736J0qAmLTqUMsWjK9gwBFBhttD2Ome3
	rn/JHgw4rGG1lBtGuJkhTMXwC0=
X-Received: by 2002:a17:90b:2b45:b0:39e:6a80:b795 with SMTP id 98e67ed59e1d1-39e6a80b8b1mr3373413a91.37.1789802010653;
        Sat, 19 Sep 2026 00:13:30 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:45e5:9e39:6356:6164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02738654csm1050170a91.3.2026.09.19.00.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 00:13:29 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH 0/2] mm/damon: fix the temporal goal tuner's size quota conversion
Date: Sat, 19 Sep 2026 16:13:22 +0900
Message-ID: <20260919071324.1583280-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() hands the size quota to
damos_set_effective_quota() through quota->esz_bp in basis points, and the
multiply that gets it there is unchecked.  On 32-bit it wraps from 429497
bytes on, and wraps to exactly zero at the 1 GiB that
Documentation/admin-guide/mm/damon/usage.rst uses as its example, since
1 GiB * 10000 is 2500 * 2^32.  A zero effective quota makes
damos_quota_is_full() true on the first test of every charge window, so the
scheme applies nothing for as long as the goal is unachieved.

Patch 1 saturates the conversion.  Patch 2 pins the boundary in the core
kunit suite, where it fails without patch 1 on any word size.

DAMON kunit: 36 tests, all passing with both patches; 35 passing and
damos_test_esz_goal_temporal failing with patch 2 alone.  The DAMON
selftests do not reach the changed function: a build with a print at its
entry stayed silent through all fifteen of them and fired as soon as a
scheme was configured with the temporal tuner.

Donggeun Yoo (2):
  mm/damon/core: prevent size quota overflow in the temporal goal tuner
  mm/damon/tests/core-kunit: test the temporal tuner's size quota
    conversion

 mm/damon/core.c             |  6 +++---
 mm/damon/tests/core-kunit.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)


base-commit: 498ee28e5ec4727f829507c4a1bde3ab1b7704cd
-- 
2.53.0

