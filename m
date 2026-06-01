Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F938D3F9
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304512; cv=none; b=Sj/tZfvVr1ZZBrV90Z24rbD27/bqcfRvPhJPNPUIJ2MgLfW8VppvkVESgfL5272uRF3K8eHBzm7+6hnwAKWIDrf53wlWMsur6azQIJczYaSZMqtSxZOwlQYyKXkjfWRY0SNwq7qdGY1Ku20HGXee0sVT1BJetP51XPH66Z2020E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304512; c=relaxed/simple;
	bh=vLILEbVUmGF4z8s96MKr0p9QRszBSgZA8sEpfRMMmVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqhrZFLtbX8OYPQ3UKRDkqvX1sq2pzagu+koG9dUEqb/oOzuFX/FcshEcd8FABTjNqS+NzuevSg6I97aJMROmT4PzwqYD7mYYKVGQH5H0PuVGXG5TnMEgQlPYA1OaK+Y5kv/08OfyitUnxZqDO7dVHE8N+mAllSwmS7nw+SsAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=R8bHB7Co; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="R8bHB7Co"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780304489;
	bh=jDNtQRi5CizyyrP7BR7riMaNsb/AxIR/vWLi1EG8Law=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=R8bHB7CoXwX5mvkbQzjdQUhcySjclr4TyEDKzacRDe91Deg04v73SLA44nOGQqL3D
	 TbSX6TU51wHiGuneSvG+hZYps445n7Mh4Oy70HEyIUp7N/SJ5/ySdHmQ9/4b2afEBC
	 hP+EnYLRzDDb1Z+uid7/LYNpu07UPgY9NLXv9Km0=
X-QQ-mid: esmtpgz12t1780304483t01ec96fc
X-QQ-Originating-IP: Ob9Bpy4WPKB/RxPVu23A0LtyCLwN5F8DUWPaVIAfths=
Received: from PEN1097 ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 17:01:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3002622667247154987
EX-QQ-RecipientCnt: 7
From: Cheng Nie <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com
Subject: [PATCH v4 0/2] selftests/damon: fix memcg_path staging handling
Date: Mon,  1 Jun 2026 17:01:19 +0800
Message-ID: <7E6EAB7C1BE04DEA+20260601090119.238457-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OY5SyXILbwKtE3uCPVi/0Yh3KKCebJf1yvt+cXombyJdoO4pjb44D18L
	kSoLgTfSbr93ICK/FQydsOIaKZhoGs25lhQ//fU56aXGchhUSXU/oBGzRtMGIEogoa+z6ns
	PAwKFDjGKMcHuJZDDUAeIOXjKHpEmjLr19C07kay71Q72jbqqE5TMKygGU594cI7TskyAQQ
	21bfHZBzLnlQ8rTek5PJ3FsLLTG4jYolGj/nZgxPF6lToLJWrM4htANeY3P/TEBFfkRVouH
	eQYdlKwTajupJrs99zVyF6Yiu3TkNVFl3wjZqMvB312kM6iPsOKWdnyRSqpH9E7yjk2qeSy
	FJasIpfYIvHIXqhPpWnODrd1hzz4iJ1L0BHXDgKylrxfKdFoq+WAgSrdGwGZ6gAjErtGlMx
	8AH+zUmyEAsE2twDpLTvlb7uQr/gNSPhEGZwY8C/FxpA2SRknm9nyWKqbgqALaOUVXkwZ1R
	l9/ETqDhwfM0YYLF5HlN4vHf3hMccBB6a7Kb7NiIP9NnoOJ9rtPDfUVjy0AQ3SA/peBYo8R
	0aun/RGgz1EnQcVbsq0C3i9anZcvYT7BMWNMg0Hv7Lx9Y4BhD0jHuJFhVRiotGprzZbU1LB
	fCUfZUsvc0WGDTrGcMde8qsTCJdYhoNL2OaPKnmbknyrd4zkhtICBaETtNytn4h2wylli1i
	WO0MVloxkwerer5hFiBA8FtU7VLfaTEH+eqjwyAlQdBpSfo2u+Oh4y75zHYBkUm085ZH3+R
	e41kXAMhqpX0XF0TJq1buRSzWu2frKPSuqQT95NRW58nrxGCqXTGIDRwDAfzDwW2gpyY7y5
	ZyFgq/4htWe8q9y/Gu4dc4mUhqzQxlVGl2G+Dxey1G5KLJ3KTS4XeCm7BjehCxOAVu8Ci9o
	kACKSbXjspKkJ7z2Ui0Mp1MeirRikVV6DtjShDix/GZrrDZzpX2XCXhGlw9sf7N+O67Chrl
	EqNhmrBeCusDfYuGxcrpZ57QJPvflw1MF+KFE54VuoAdceJ4XaquH2wpuHB0fVXGo6s39rm
	+qerLx6YN3BNrPU2FAM+JyV5bBUa+w6TmJkE/jAh4I2XehDgAU78oJSCKV4v/H8s99P5pbk
	HJqsvf75sBz
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Changes from v3:
- call stop() for cleanup without checking its return value

Changes from v2:
- configure memcg filter before start(), remove commit(), ignore
  start() failure, verify memcg_path staging readback only
- use print-style error messages as suggested

Cheng Nie (2):
  selftests/damon/_damon_sysfs.py: fix memcg_path assignment
  selftests/damon/sysfs.py: validate memcg_path staging readback

 tools/testing/selftests/damon/_damon_sysfs.py |  2 +-
 tools/testing/selftests/damon/sysfs.py        | 31 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.51.0
