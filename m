Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B147ECF1;
	Mon, 14 Sep 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395606; cv=none; b=nbjxlZM+9USJbz5/LcHvzaYBXtcBM7YpaDo+WXnfuMZWDtxBb89+CLkZc6pjiMOsERl3kL5ElJi9XAsWjw4KtUhsifHe0nQwNT1tWAR/j3L1hF3DgObkReulWR9NMqUCc0H+dRYobXv5iXQAqNLIIjulq8p84QJnl+uuX5W9Ypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395606; c=relaxed/simple;
	bh=7ci7gxigHaN7jPfqDBRzBjI6usIiTTD9pIeSrMF+tnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8Z6x44uaauOUOq6HpU8boyDz7cF9ivCHlr5xOePfnGnPAt83zwGskJGCZnjszQG2huVA5lUcQCg6bLgOIjOSd+HjapawKHUQrb0iqu+/x1IB+4+CyQoSPx7Lg/SKecl19L7IR4ajvYmm7MnhQcz7B43bexsJ7llSfyPmnDecco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTISd//d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTISd//d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFDA1F00899;
	Mon, 14 Sep 2026 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395601;
	bh=rrDgkODM8llf8jq+hclXZEjgX/fiBHh7K7zNkR9oULk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NTISd//d9p3BIEpa0p/qxDk/GpV/LubuO5kaAosPlh7zMJZu4RN5PxiMOXsAmYxHr
	 PEIB2PhPz8qz1huxQTukkSECJjgsViJnj3edZLoC8fQHsLE/GhA/pkWel1fyZFYRNX
	 PjD5RSc6MZ2GklIkHFAn0YY0YmF1Ljwh+fu1QopZ4u8kWsodrlRohmnqGT9kxz+9gP
	 elMt/MR6LAI2KIl7yhDF0FreaLTVo6BuI/rBdebioTyW+lg6CRd5dzvQ1oI2CvPAFD
	 rKtJHxGMnFOYPGVpVaQwkcGiV9aYBliC6Q0UAUQpv9mMKCQCXl69TQqKFrPeLLnb3p
	 8iaOcc/QSUj+w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/6] selftests/damon: ignore test-generated damon_dump_output
Date: Mon, 14 Sep 2026 07:19:47 -0700
Message-ID: <20260914141952.91465-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914141952.91465-1-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

sysfs.py and sysfs_no_op_commit_break.py dump the DAMON status collected
via drgn_dump_damon_status.py into a damon_dump_output file in the working
directory.  Ignore it so that running the tests in-tree does not pollute
git status.

Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260908162716.85648-1-zenghui.yu@linux.dev
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 tools/testing/selftests/damon/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index 2f0297657c816..226bd7c4e0728 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 access_memory
 access_memory_even
+damon_dump_output
-- 
2.47.3
