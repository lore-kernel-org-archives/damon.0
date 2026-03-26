Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBF638C2A4;
	Thu, 26 Mar 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506235; cv=none; b=KJbjW5qGL49FrVlxivgaoDCLKbxWF5T1A+UfxZHk7v2W1WocNky7KQHUNykpcUhHJZxdWTt+3SChqJc5Q/+wl8S0rqvU33u2ERBZhj1pNtdQkATIKReNR/nimx4B9h/QnlscbLD2Nj8pRLzVzKYdHF8yfHabQJ8Dhv044Czx7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506235; c=relaxed/simple;
	bh=dMVkNZI0wrZB9u+j8RryzXGldt03j6+1zZalaSs4HPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StC1yyt/NKAh0TdsOd68gOtSeY0gwHIqj/1MSaX959hH9ubyC+0YWYnv8rESzxY5sJQh/rJv/i/PmdHefojZokUYsZNPOkjyA9tYjBKvkmP6S5U3rw/BNYK9FR+WT5TrN0NMOdnrmfK2fxBdwU16CqeFnxyzoO69osRNm/I7xfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+uJC85q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+uJC85q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C202FC19423;
	Thu, 26 Mar 2026 06:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774506234;
	bh=dMVkNZI0wrZB9u+j8RryzXGldt03j6+1zZalaSs4HPk=;
	h=From:To:Cc:Subject:Date:From;
	b=E+uJC85qyaMArvOTnBRnTOIzI4VauEoEOhqf0nStY+z5t/FFcqXGpbFx/AH74OfUS
	 G+bI4keNhe6LqqmZQkrSv15BhoDe/xX1e5AtPc2mXm3DjmWrC3KN3RbOd7k8X4v5ZH
	 WA+xmGusGmJm2UbPkk8tKUwiQbxtdnD3VVw0J1f3sRE5/lH5ucl9aorGg++Ze82Kxh
	 4dCVtUZ0kjLxImpsgbVn1T1kAcFSOJzgsDicafpg1ykPaU3GyllLfzQ/w4EJvAzwPe
	 aDJwGfpFiz8Ntl/JR2+nBCKSMZ0/um82NFCuVmw06tBGQRPfpjBcHGpPnSmg7sbUNa
	 qbRivVt6uLi0g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon: fix damon_call()-related leak and deadlock
Date: Wed, 25 Mar 2026 23:23:44 -0700
Message-ID: <20260326062347.88569-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_SYSFS can leak memory due to improper handling of damon_call()
failure.  It can also cause a deadlock due to a race between
damon_call() and kdamond_fn() termination.  Fix those.

SeongJae Park (2):
  mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
  mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock

 include/linux/damon.h |  1 +
 mm/damon/core.c       | 41 ++++++++++-------------------------------
 mm/damon/sysfs.c      |  3 ++-
 3 files changed, 13 insertions(+), 32 deletions(-)


base-commit: 2b3fbc1796d335685d9b7a825c621914a1c97d1d
-- 
2.47.3
