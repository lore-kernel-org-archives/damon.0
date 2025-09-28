Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0218C03F
	for <damon@lists.linux.dev>; Sun, 28 Sep 2025 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759042030; cv=pass; b=jVBulLzcpeAZkX9DuHHU8LobTqztk+QzwWNap1m3AyrvXLXoG3G4wiPkpq+w0kqQEp3iVRquLl++RbzVUQ1CM77PSjyjr1TKYoRTx7AZmIcYchguFkgG54j7m6Juii/zJlSo2Bj2e9bwaGWKMnPv7fJ5wfUT7Vwgm32oyk3Sq18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759042030; c=relaxed/simple;
	bh=t6ustQj7Xfe3HKiERNgrVHhh1pz2uVuazT2CqYYtX+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p417n2Y3EodUUkT4EFwO+F68CftCzdU9OiWmA6BdEU6pKz2TTicHVZptcsGTTuHOPfAnEFFiCU1FiGxT1UvVgbSjsQfiVdLe99YzmfoVh/q1MHKx7dJJDKAd0qy5pP7N2gy8WPD8fugjb2ga7gdFPoIHOA7zafweI4e616C15n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=G5FUZBjF; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="G5FUZBjF"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58S6kw0D051679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Sep 2025 15:46:58 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id EA234109EFD83;
	Sun, 28 Sep 2025 15:46:57 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SgMd9GkpPodp; Sun, 28 Sep 2025 15:46:53 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 7E3BC109F2881; Sun, 28 Sep 2025 15:46:53 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1759042013;
	cv=none; b=j+K2CKhOHrESoUHYiYOGxBoYd5j9Ey0b6TSHGOxPbSiDseNnNGvgsXvcfWta2V+MU1Agxf+CPR7Uhi+35UPwn+JFaE+fsnU8LoWnkw6vR7YREyEKo0GK8tMeSdMuxgXO53Z1jwL/tWOb29VErxX0nrrIru5g8denNRxDV2eXnZk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1759042013; c=relaxed/relaxed;
	bh=t6ustQj7Xfe3HKiERNgrVHhh1pz2uVuazT2CqYYtX+I=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=HMt32kzNplHxRIZjrssxUZ4FLxqJNmv/Zxj87Y/1ubBx/yWTTGSsij6tm2TCUjyrkSreUm8oIzzBduDm2lR/NU6Ax06vX5BLfBFTkz8D3+RektbLNRRGwQnM16ADFqO0JWlqJQSg0l8mcDzqEemXh+pymgcw+Y9FaWl0Hm7+Jq8=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 7E3BC109F2881
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1759042013;
	bh=t6ustQj7Xfe3HKiERNgrVHhh1pz2uVuazT2CqYYtX+I=;
	h=From:To:Cc:Subject:Date:From;
	b=G5FUZBjF1himgrUO+Abz5dIhQRc4vg2jEbeUDp7PUr7P124LRQKP9/cvRKq2gTzYD
	 omm6HWFpg90h5Rzy8H6iN6l3ASPQBU0vN69rVdTHFM43IfqsEV2IpYkpz1wlLjXZ8q
	 bYVsJ7nlNChytAX04H5zYyeONUVWQOsXUrnY2U3o=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] docs: admin-guide/mm/damon: Correct typo "directores"
Date: Sun, 28 Sep 2025 15:46:51 +0900
Message-ID: <20250928064651.281325-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The word "directores" is a typo in usage.rst. Correct it to
"directories" to improve documentation clarity.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/a=
dmin-guide/mm/damon/usage.rst
index ff3a2dda1f02..5cd42d428c89 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -357,7 +357,7 @@ The directory for the :ref:`quotas <damon_design_damos_=
quotas>` of the given
 DAMON-based operation scheme.
=20
 Under ``quotas`` directory, four files (``ms``, ``bytes``,
-``reset_interval_ms``, ``effective_bytes``) and two directores (``weights`=
` and
+``reset_interval_ms``, ``effective_bytes``) and two directories (``weights=
`` and
 ``goals``) exist.
=20
 You can set the ``time quota`` in milliseconds, ``size quota`` in bytes, a=
nd
--=20
2.47.3

