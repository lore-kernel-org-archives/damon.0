Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795892442;
	b=5SxPKw0+TSjlt6OUqUcOdlixV1dyXb+DH6jwq90k7OTY8f13SFLKgB+R0kG/EpXAeeOy
	 HhtLVkEptymfJ91TaVvvGPFKlY5pnI6AgacGSQhaPpLx70oi2NjWQbP+2uk0//6yPpfOA
	 HCPIQb763+B6o8T8djqTSLRduvUKbbFQrjk42lIB1PN6FGwWoQq4qZHFvBnpw+1hJCH4y
	 G2HeeKGeg1FSlALYyAvZKyRwX0zmhXkw8rKtu/HSUacG9B4b7w0BTNkobr0pNgEgIun0N
	 R4I/Cw8xL4QdrDDSbgrTmmb4RONFcLLtQj/QBGKd/MLQwf6WDBU32iZxTnVUWUymL3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795892442;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qUZ1Sh0+x+PxUSd04DpLnU3Boe55h78UdXb2EcapTys=;
	b=4DAdlUrg9Y/bR+zjDg3qeXIlB7YHWJkWc5cnmcxtXDMr0nPgxCxSS5/Jud1LCpLEH+D0
	 mjOy3unUqZdDVIwSJYS+9VN8ejGv+EeotBLOBVmtfWZVlF7iQFSMMb0zzi9AILEtkyMoZ
	 ypli5EL5teCOf/JsQIOxFny0lk9h4MucIIzpWAEenEYo3qqzFCYu7bXAkk2Iw/n5oVG0V
	 rQFu9jmYn6Cz0hYO5AIxHU9/Of39x+L//sjx5+zpIN8k1zq7m+exH3El6HUIGVet+fsI1
	 JrRY/KNZBp8kVo2UsibdDnhhNNHiUzfUeRIU21sMFzyGWnBSbY/tS6ryXxOW+4vKUnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=giILd4la;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E0606A31C;
	Sat, 28 Nov 2026 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=giILd4la
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7AD1F00893;
	Sat, 28 Nov 2026 19:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795892442;
	bh=qUZ1Sh0+x+PxUSd04DpLnU3Boe55h78UdXb2EcapTys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=giILd4laJn1arNGe2gjeEkdUzhMop+yNprr6o/vG2XYa01P+WsX/oh/2Tr712+Npz
	 kLiqMppcExF3Bykis+Ao1p6cwe9x/bDqgRh9fPY8YLWS4skkNkluOJDT8lDutveBil
	 PPVFzEAwiEmE5x4Vn2kM8XB5m1x8QW2KVlOGzsddijAS7E9wh9uxgiexttaL0rMEvp
	 wAKfYN9JEmYPGNFAi98PdnpFkpyt6z6GPqnBb4U5aJw2uTkEaVQRbcADAmB2dfU4Tr
	 fo8ulXS99TheW0QgmuR8xWat1FFEFd7AuGHxAyMAjoMLxeratvPDZM9KmwtigF/0e3
	 4vhhI4zHIgbhw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 5/7] selftests/damon/damos_apply_interval: remove unused variables
Date: Sat, 28 Nov 2026 11:00:30 -0800
Message-ID: <20261128190033.164440-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261128190033.164440-1-sj@kernel.org>
References: <20261128190033.164440-1-sj@kernel.org>
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

wss_collected and nr_quota_exceeds in damos_apply_interval.py are
assigned to but never used.  Remove.

The issue is found using flake8.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/damos_apply_interval.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/damon/damos_apply_interval.py b/tools/testing/selftests/damon/damos_apply_interval.py
index 0bf7768b2006..0ad110be0fb9 100755
--- a/tools/testing/selftests/damon/damos_apply_interval.py
+++ b/tools/testing/selftests/damon/damos_apply_interval.py
@@ -42,8 +42,6 @@ def main():
         print('kdamond start failed: %s' % err)
         exit(1)
 
-    wss_collected = []
-    nr_quota_exceeds = 0
     while proc.poll() == None:
         time.sleep(0.1)
         err = kdamonds.kdamonds[0].update_schemes_stats()
-- 
2.47.3
