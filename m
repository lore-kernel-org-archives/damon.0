Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553399;
	b=Jl4neQCVdKoBDqUYfi9y4ELq8mtKWXHg/siQi2G1o13V262B2rAiVrd9ra4yzrI4Kf94
	 9fFansHOVfS2zjc5H6T60Ak1211BSpQHbdujPXUQ222YAltaHoRmkfT+aiOsW/mxaxvj+
	 cHR3OIo2BUL2h0c97q34L+/7vhtMLIDYQxeVo18LsWlnWhrzcXFDO0g5JOq9W0N8CldOD
	 MDluPANKzFoAcD+DkkaOc/miSzqPf4iLzyR//BJakFC1LDxe2x/tj5G0SPS2seJxsB5rU
	 bpXVLP9c+6ry4yBIOTPxXO9IxSK4egdJbgKjNwIHdq0Slb+2reo7PpbCk8iJNMywP9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553399;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9FIAjLQl49vWGxEAT5mry9z/qprr2ACY4K70jv59AGk=;
	b=O4MQ5rn3x2xlx2NGSNp0kj9YxCVD0JZtmfAC9bEW/us4iRBt+el2bNmUQSvJzblfUccX
	 Vtqr8yPoemDXBPz6VYhXwUQMNSwcUNUBIOwhUkQ+mZ7ZSd2/ZLyjUM2zVA+eC2kKA1cQr
	 3TlwW9e5OcGOEH36kflW5D3OK/QTDwIgfod4RPn1tif1PXfRFzuf8Zpf/kn8UFodZBAZF
	 gyjw2smm+H4gSlXI0wHYSqhTBRRFZqT7DGZkgYI3Kp/dsoRbEUNsMuF+7VnBdCxcY9uie
	 hDanhS/tFYZ+HCLiD28wQKq5wymbzgbP7BucJmPfqPM8Pt91gQrxgKsGgqR2u9VfMug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCdRHVbT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6033606A325;
	Sun,  1 Nov 2026 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCdRHVbT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183001F00A16;
	Sun,  1 Nov 2026 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553398;
	bh=9FIAjLQl49vWGxEAT5mry9z/qprr2ACY4K70jv59AGk=;
	h=From:To:Cc:Subject:Date;
	b=fCdRHVbTv7LssVGIaJeoJS4MdHHPVs9+iHHW6hyzu5w1w5Y6o/UDhYyRW/dIRklP9
	 yloZkzUlKQldmVHFvh4o+n7mfWqaz62e9lKgkuexu1b9ipH+ZqMRB6rqXgRC5x7yAe
	 vA3CNOrQ2yJK06fJl5IqTJCn2RvN+cRDMKFTtCU7ZhDQQfDH0C4ajQ3pbjnr+ImD5R
	 qZ5Zug2sS3UiFx76sr4iyehCTX/8KgHXuWNED2zVWRsyhX1aB6dI7oRiqNNLFMkJBG
	 +fOxNd4LC0QPoGfYKDnnKwAT1tAvtgJKUNVDYSYY2EoWU8vUvV3YoOVLizt4+qB/gf
	 YLJxAyXuWkD5g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/6] mm/damon: misc improvements/cleanups for core, vaddr, sysfs and tests
Date: Sun,  1 Nov 2026 09:16:23 -0800
Message-ID: <20261101171630.81477-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor code, optimize code speed, and add missing feature supports on
various areas of DAMON.

Optimize the efficiency of vaddr damos_migrate action under filter
failures with patch 1.  Use damos->last_applied on damos_migrate action
in vaddr and support sz_filter_passed for damos_migrate action in vaddr,
respectively with patch 2 and 3.  Drop a redundant and racy quota goal
target value validation in sysfs, in favor of that in the core layer,
with patch 4.  Drop unused variables and imports from selftests with
patch 5 and 6.

Changes from RFC
- RFC: https://lore.kernel.org/20261031202614.96036-1-sj@kernel.org
- Drop charge_target_from fixup consolidation.
- Add a patch for using last_applied on vaddr migrate action.
- Add missed damos_va_migrate_private->sz_filter_passed setup.
- Fix wrong commit message for unused imports removal.

SJ Park (6):
  mm/damon/vaddr: advance migration attempt in folio level for filter
    out
  mm/damon/vaddr: use damos->last_applied for migrate action
  mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold}
    action
  mm/damon/sysfs-schemes: drop redundant and racy zero target_value
    check
  selftests/damon/damos_apply_interval: remove unused variables
  selftests/damon: remove unused imports of os and sys modules

 mm/damon/sysfs-schemes.c                      |  3 --
 mm/damon/vaddr.c                              | 28 +++++++++++--------
 .../selftests/damon/damos_apply_interval.py   |  2 --
 .../damon/sysfs_no_op_commit_break.py         |  1 -
 ...sysfs_update_schemes_tried_regions_hang.py |  1 -
 5 files changed, 17 insertions(+), 18 deletions(-)


base-commit: 807c0ce92f8424fbb7eb13e7ea48746f68b24dca
-- 
2.47.3
