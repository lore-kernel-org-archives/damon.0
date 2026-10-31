Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478384;
	b=XJn1IR/YqnTbCwHXjQbRb1bspp6U7hQv/r+38nROGnX11WvR149JRqZJbvipsfXzO8Pp
	 CcHKMab2P9RS5t8XDKm4ty8i+9evGU72i6Nqjr2lZwROYeGqJ7kAOFF/aRd2wJQa3yekh
	 dEHnijz3MecNnM24Gyx4pxx0lXyluKT/w6TpgQLT4IRKpdKj4Np2lh5srdi1g51WRTzce
	 lH5vDBXJm9iB6l/RnhKbaJa01crbmqc4riW0Wd+MfdzLCS4Bnghs6VWY1+VkqVZxR9gVJ
	 bRFMIwBXkCutahB03SkW6n9E6Zbm0Kxm4YHuHvdlvRT2r5OQ02lRH2w8+crPFleYLBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Nl/jwuQeYoLkJzo/bhBa5SyX/AJXXbPvtIr1rgEJpfc=;
	b=WELvfDKIO7QFR4hvyIU1NOWO27n2So6wt1uLI7cIlmbnXLHbF30mo7j3TIkVxmt7nV03
	 G0RrjdK3sTS7aRLPeYKqfEYEj1v3/kRxhvaeYBOeEWsaFc/3diNNe6vgK+vrI7/bn/yln
	 zhuWVU2E6NQcW16Lz8eRcckUm2cSWnaMb4V9zM+Bam06ElozVDmlRo4XzsKXQ+9sa/KhR
	 QCwe62ct3VTUoNRx+IsSq3xJdeXZdCfWYuvKW4kIbia2vgkoHB3Q9niPerrr9TyQpB+F3
	 7MdMX5hUmOu8RCXJdEFi2qiNrVLw4QS0HpyUq84P+p7Q0oK1BLIQtHyOHprAmuEsalA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPb2m8Gh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B47606A333;
	Sat, 31 Oct 2026 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPb2m8Gh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23F61F00A02;
	Sat, 31 Oct 2026 20:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478383;
	bh=Nl/jwuQeYoLkJzo/bhBa5SyX/AJXXbPvtIr1rgEJpfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZPb2m8Gh6rnTXbroSHauDyU9CHuyH220YgRt0Dn1rHI18EQmlKWyqR0eP++CYByBY
	 NUrVbs56SKOyVIzXG83r6fBDDB8fGds1TfvEP2XUBz5wCIXZwvFcZ/e7KQPDndwHIy
	 zDl9aSiQk+1UxMSsfqqbTs0BT2iwS1XrwlwLbgN6z40ko8pupuuSXar08cWzyZk0bB
	 YTHDuN+EOWzLXEKXn+XsLEAoTNAltNLzVpv+Xqn6Z5/4mlpIX5erm3xA9LQbAx7zqO
	 U89XSlkZKRS9IVYE9l0mcAHlhnyoHMIZ5MwJUlumHh4dJny1q0ZfDD94li2W0lp7a2
	 p+eIP/3YiWgDQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/6] selftests/damon/damos_apply_interval: remove unused variables
Date: Sat, 31 Oct 2026 13:26:12 -0700
Message-ID: <20261031202614.96036-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031202614.96036-1-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
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
index 0bf7768b2006a..0ad110be0fb94 100755
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
