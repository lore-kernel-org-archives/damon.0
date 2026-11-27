Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818449;
	b=iVCv5Mmonvc9j/7iYG4DIDXl89ddNmj0jqXeynFgPLjtcX/OVFnnUSrF25HI5RxRcmXg
	 30ix300VSKHYHHjxp56wb+ihgcPSlV9k+On3iD5j50hSQG9WlLWXHFg2ylvgAsPmNNmr+
	 T+mXw5RRtW56vOJ5c8Jc4nlM1JKDCqKZ81DHeAl7zJYN2ko2Eh3LV4kZnsDdCILFYbemq
	 4F0rDE6yZpFeUHlYbDe8OqmPNvg+MUFHmPulKpKGCFbz3LNvdeSKrhEKkiz5kgC+JQVBQ
	 SYchoRmDSSSFbQkvnSIH58rGKr7wHviPExo+wxYJqvA4bxTNyX2q9IAMpzTqjtCcG6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818449;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qUZ1Sh0+x+PxUSd04DpLnU3Boe55h78UdXb2EcapTys=;
	b=HwYe6+LGWwkPBVLg0vbjtxSSvqBgvfS+jP14J7Pu62kxf0ZUqSb9U+ognGGuo69nuC7d
	 Fk2c8iS3Du4Zn0teIN6O2z5e+Rx646PkaXQnNPi9OVrK0Ilz0FU1cy7w20HFK/nd1AP9e
	 5JlprXmW+vvgNH5d7DM/pnGOhgwGX5EJVatpH3Z1Gt/h1jQ79k8ZU7pg4BxnONaRxGxcD
	 OMFe7cUzl8s/UdqDhe9cgOuuG5O8az1GDTa30wYZaM5mDpWEuy6nLaNfN3xzaqEwoZxU0
	 DW0ksqlhyB7GoUi/j/xq+Ewr73/azX2S/dkio75CfkmG9YX+rF8AvDEMgQJT8/S8SWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lpvdy0fJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA2606A31C;
	Fri, 27 Nov 2026 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lpvdy0fJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6041F00897;
	Fri, 27 Nov 2026 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795818448;
	bh=qUZ1Sh0+x+PxUSd04DpLnU3Boe55h78UdXb2EcapTys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lpvdy0fJY4bL3qswTGbOzBsYWQIL80Hboe+LmS4j9jTVew41uBNeqVNIusViDV1Ci
	 y9qL768zlu1ivGlqnidw6e2PEQvsY79vsyWSsASr9QT0PftBUnaAAVrTY9Ismcx7FB
	 Fny7zGQPKM2T8CUdWCdv8lA/vfyEceMUKHgsCQdbNZnaEzB/jVyzESlQzEyUFjjoFo
	 uq3kezWDbZMQQ+5BNj/aYtAaI8vafItDlVkUH3n/3NdtAGE024AAPJBY0/pYnT7YCr
	 i1pumvL6m98xFz5+1gghrCajt1CyZI/58O+Mqi6dVaFlI5aMRMZA7zal0lwZcgcUTi
	 4oAypdeBhG9ug==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 5/7] selftests/damon/damos_apply_interval: remove unused variables
Date: Fri, 27 Nov 2026 14:27:16 -0800
Message-ID: <20261127222719.105510-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127222719.105510-1-sj@kernel.org>
References: <20261127222719.105510-1-sj@kernel.org>
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
