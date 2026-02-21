Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA19327C18;
	Sat, 21 Feb 2026 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702597; cv=none; b=naZhgFCWuphxLrycXR7XnNnwTa7Yhcn+3MMuWKuNKpzAclkh3wNgPnTkzOiYKqC8msgRDjmoTUmcDWAN03VKjkGQRUE+6ZilqvUxUzxaQBOi8zeul3ssGM0nHov1FICnk6/AZgYjOoc+izj1WlV1U39I8eEYEq5VKLRRNqWez0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702597; c=relaxed/simple;
	bh=iYt3HJjJZ2u5nNYQJzA/aRcSczmrsEXHtQU6RM/AfoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlnuVJL8lad2rYQraeuYEfBshQOLRq+htH7tZv+ZGJr7GRriRDKd3rBR/4aT4yQHz38VpO3d1lEQNErhr3brP2wQZvTwaIJ6yboueO0NlNJNXd8H8cX0/WL3npfEqTM3cNYjlLxrVf/GfRrcrtWXV6fohjtXdYtEtne46BOIzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzDLCrir; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzDLCrir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76021C19424;
	Sat, 21 Feb 2026 19:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771702597;
	bh=iYt3HJjJZ2u5nNYQJzA/aRcSczmrsEXHtQU6RM/AfoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NzDLCrirLxiXJ5MTJob6eNXmUGHqltZBK4hK3K0ojglQ/kKc2jCJd25QXbbRj2Ur0
	 iBSBXBBAG2ggVEbKhok1CboQbE/p4yB/MIXimsyzj5hbKHv2C0+1PHD5PrBfprXSuA
	 iI9BBmHp4AvcOhm97QzFfcBMvgSbdkO9YlR7EwH3JOS1o4qeYOo3zldg9cRGehVEmE
	 zqErZ2xaNFzRBlDtjrETMekCQ8YZMPLJjYR10du2COPKT5A5KwGoR/RXhu86MyVCz8
	 8aWb0SLnTdrTljbn2zODv0ipNtRK9s1HND3HJMEEw5udY9vRGYU6N1yxatbheZOz7d
	 I5sthnhmS/M9g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/10] tools/testing/selftests/damon/config: enable DAMON_DEBUG_SANITY
Date: Sat, 21 Feb 2026 11:36:27 -0800
Message-ID: <20260221193629.19332-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-1-sj@kernel.org>
References: <20260221193629.19332-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DAMON_DEBUG_SANITY is recommended for DAMON development and test
setups.  Enable it on the build config for DAMON selftests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
index a68a9fead5dca..6304adacb741c 100644
--- a/tools/testing/selftests/damon/config
+++ b/tools/testing/selftests/damon/config
@@ -4,3 +4,4 @@ CONFIG_DAMON_PADDR=y
 CONFIG_DAMON_VADDR=y
 CONFIG_DAMON_RECLAIM=y
 CONFIG_DAMON_LRU_SORT=y
+CONFIG_DAMON_DEBUG_SANITY=y
-- 
2.47.3
