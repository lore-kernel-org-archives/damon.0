Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FC38735A
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299455; cv=none; b=eYrq2cf6fiwk+2UWsWI/eFGFbUVGxBHq9B46EN43h0HafnY+uU19KF/7UfsUsc6OGzxjIZ1A1VLQJihRMt9NIWWbAxHJJhQ88yY8n6jJEdzbDwP2C4PMHz2lgQsMAi1esaZUCQzTPpH0JX5q2i/uGCHiAXOOI2JgkegTQbe4F2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299455; c=relaxed/simple;
	bh=ZB0E61qipt+WfidlB/lN7rhIZj5ewX9JExdsMvUcRRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pg9WOK3SSfPGVB7xOHM8FSWum3FENokzlf54lU3BflxydhO/GSa77KWVJVA8gOzsWwmUi7pR+QcYJ47EzdWa61Fwp4kx6PbyejUa0xd1J8TKdCVDp6neqsLo6bBtkw1IKt7uzFT3b9xSfeEe9rv6JaNYQrq87g3Ub94/K4c/wv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=P7Ebjget; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="P7Ebjget"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780299406;
	bh=uH0zhOPDX9cTobLGcddQPX+eW4noEIYY0qYKS33IGqI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=P7EbjgetcYJ8lxf8/rwelB6wbQ7f49xIa/gLuKtCyE8CLoy+zFe0+asCxuwsj5mq1
	 rQsprf5gMLNjcAI9jJj8MSXwxW46YZGVBp6xU/U6DTIluZ0vQHbmZR0YS9vmDbdpFr
	 d4xf2rsEp3KE6NrAYF8xHHE7eZD3kmY4oajgrFAM=
X-QQ-mid: esmtpgz10t1780299400t9453c59d
X-QQ-Originating-IP: KmpJ7xKXL7U5Srup1auzkXsFPcKbcVshfHQAinW5GIc=
Received: from PEN1097 ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 15:36:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4375497483461457750
EX-QQ-RecipientCnt: 7
From: Cheng Nie <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com
Subject: [PATCH v3 0/2] selftests/damon: fix memcg_path staging handling
Date: Mon,  1 Jun 2026 15:36:35 +0800
Message-ID: <D4787203018006D6+20260601073635.200015-1-niecheng1@uniontech.com>
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
X-QQ-XMAILINFO: M8JnMGwRo1mQwuulEozvWLQ23ukuXx8pXrx1GlqIhTuKO2PJ/0OePTpa
	nUwUHBsPCF6JglQ/2d1Eoxu7YKsFfyVyjloUPNG2Id/AUmS81SuM7ylXZJPcr6/ICkcswDx
	CLLf4gDq0AjA+sNt4orqd227+n5nfp5Pq+A13qFb1LsMreR5U0ZLL+hwENDGPp2MhzfbdO2
	4XUn0UoIWGyYcxVII3q6TU8dPbtFTZZL3e0FPWNMBQS1RcHeBPRWInnIUX5DfSG4F0ycTIJ
	YGk1gWttLzoEmacZm6DQOnL4/j5C2EXIQLQGm8TszHjYnbTQFpYcWK5ZuMzJyyl2XDGO5Kq
	+zNf1lw03awTAJaCH42U9m3/75ECztK4ytE1gQilaERYDeW2yW864ynjCBaSjKKR/RgKbJW
	a6k6VzbC313tksA8iEfCHU3C0Syv+VHl1JNP/DScygidXlP3D89nu0qknpFAv1SONxwNFNV
	fGfOrB2Yv1vY0/ueABRE1PxwP+Mm2xFt2g6QW/ZAP6/wpFXPodB/aoOyJkhRytWYzpd8KC8
	SgkJvKnZI5yPYHeUNB7PBkrP+zgv4K2x+4iv4Ikyk6zxz9BF0Jq7ZNXv2OZabJsddXFqoLq
	nLppWhCxCz1a8dSMqm9YDuznWzjX0VusnufChaTtiNqINd0zJ8N4U6tL7PGT8ZHhxcPEuwW
	k+0Vh5lReggJbqc2Ly5YqlAN9Y6n2/2XCF+0ZRXE1fPGyqEOvpaUxVrdgKlMU/Qh3PzWmNS
	AUEo+oh03MOrPJqGyYaTgcqEcEvw2qDJvgDxVoY8VMOMxMxCbIoEjcnGOIKl6zGdvZPG2dl
	oxfBqsbF5QngFidyG2utNKhAVW+PQzMemo/7HGg59olQhoRl1/AHPg71tjlQof1OoQ5XTBQ
	NU5hC/oBVaEIWvhXcLVCux8m0Jyo1/EFEk4peKLERcTuHo8LrvDsVo7ckb6B1K/aIMo28Xn
	0EjlsSY9Zvtaa5OaB2lOa1ekku5hKIE/ITcDb3Tx+UeRYKBR7GffKbhnzYCFEEgWUQHjT95
	4TsoPPOIqR8B4wZXFvlYDhc0Z/AnDje89sZ7o/MX7BoCz4EtsOgnmuVFonjBkmTQOZ7lmCZ
	A==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Changes from v2:
- updated memcg_path staging test to configure the memcg filter before
  start()
- removed commit() from the staging test
- ignored start() failure and checked memcg_path readback only
- adjusted the failure messages to follow the requested style

Cheng Nie (2):
  selftests/damon/_damon_sysfs.py: fix memcg_path assignment
  selftests/damon/sysfs.py: validate memcg_path staging readback

 tools/testing/selftests/damon/_damon_sysfs.py |  2 +-
 tools/testing/selftests/damon/sysfs.py        | 34 +++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.51.0
