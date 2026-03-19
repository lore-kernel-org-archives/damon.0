Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADAB39B975;
	Thu, 19 Mar 2026 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897729; cv=none; b=hmS6yVGu7u+P7uRAV8sXqp7fzQYnVkexEf32ZCNbjmK2eHmEFP2KOvz/ayufpnKyQALzy5KkmkJzHTbdNDJVw3KAnsdVqajAcVS3Tzg+jd1bjAFkuWVm0coBICpfaT1SwZg8w9RIRqQ1I7sNCk/eHIo841GAfs37e5gnhaYhKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897729; c=relaxed/simple;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VP5n++L7rm4iO0wI8F9AH6o0ccKLIzEN4Xbe1rIyqlPaacFefQiSSiYLol9yV2/eMUuH8ccEWWLTImC/IKZOAACEXoam0kUtuaJTqpd8nbtX5IWrbghA3owuSVDe+skO4pB1P56G9Q/YwYgi8jtYrXmfObCu4CxIqb8xMY1sELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2TPMNRk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2TPMNRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340DFC2BCB3;
	Thu, 19 Mar 2026 05:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773897729;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2TPMNRk3SQFvWn3IXoQNGAZczLvJpdEKEPh13gBFvXGyQ4+SPzZNesS6RWSv7CfQ
	 ALMgqHWpyRzbGS3qEFMk6VvM7JhXGGU6inqSSIyo1UUsg10kiSws/FyB9tcwg/huiB
	 eAJhSr9CyB/jZNeEFwNFP623LpBtAo5HRD4+ZZzRkgoEWsKb7t2WPZPc8JOwdklpvt
	 AyqLSKccVf6ewktCkY2KfAE3aFOd5ys2HNRihi7vG38hkzS4nhfevXvUxcu9B6LYEp
	 u/WjZEgxjAs7+JzwztOKWXkzHt3wRQN9yb+tVPNBuFkxTbU11DKoVTSpDD1+nBz0rN
	 5HOi9MMGNdbWQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 08/10] selftests/damon/drgn_dump_damon_status: dump pause
Date: Wed, 18 Mar 2026 22:21:51 -0700
Message-ID: <20260319052157.99433-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-1-sj@kernel.org>
References: <20260319052157.99433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drgn_dump_damon_status is not dumping the damon_ctx->pause parameter
value, so it cannot be tested.  Dump it for future tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index af99b07a4f565..5b90eb8e7ef88 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -200,6 +200,7 @@ def damon_ctx_to_dict(ctx):
         ['attrs', attrs_to_dict],
         ['adaptive_targets', targets_to_list],
         ['schemes', schemes_to_list],
+        ['pause', bool],
         ])
 
 def main():
-- 
2.47.3
