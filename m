Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99B63BBA0D
	for <damon@lists.linux.dev>; Fri, 29 May 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045768; cv=none; b=dDl1i5sDdWsxIQYGpzTHbusL/s7ZByEZ1mTS0MBkhq6gfDjvJ3cpk2WOnENhIou7//RC6oWRw7xW14/X+FXYbwA7xm2JwWnGaktUuRvJQrylarpFkvPmSm6u4LrIJO+6VXZzRvYaEKIdfUAu1lVQ2lHbOM0f1e9172X/qP+dawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045768; c=relaxed/simple;
	bh=W9fjqS8dmmcQqzjKznQsgx7cDBa1F5ETa1t/sLtIyoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VL3TeT2cYhOvmdwUQJoYyQ+U/CHVruX/G1jCli9Jqwf9uDUv6TTyj1srtHE8i1KRNq4xhzj5g+dqx00CBUL5YvtfAp5Fm1jBuvee90qw73Q6PkmGw3RLVGZV7SdwaFeg1x5qXLHVm8cl+0EaCk88y2IqHx6cfDDt+FJ/k7xEwZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XpOnvwbD; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XpOnvwbD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780045746;
	bh=HI92CQVY4BHFkBuTuF85nDRVdo5KUcgUaAWuBzvANXU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XpOnvwbDqjaK8u8fRk0/pnoS7fdyZRDiQ/LeAt9Ym9SvLK9rweZI5q3Bn+Wbvmp2r
	 /pTbm9BbYOJD1AKfo7Qod4qMZmvTdaJuEpMWIk1SEgPW/mRYm981OvEhgOZg9MeArY
	 497r+qOT7bNLPCIAO6Q48DyRQY7FPnr1HAh4yo2k=
X-QQ-mid: esmtpsz19t1780045733t2faf9186
X-QQ-Originating-IP: ryROh8tfY0IVyLUNcxiOovSTwDyb3oq11cz15UPrYp0=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 17:08:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5547347000364667958
EX-QQ-RecipientCnt: 8
From: Cheng Nie <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com,
	niecheng1@uniontech.com
Subject: [PATCH v2 0/2] selftests/damon: fix memcg_path staging handling
Date: Fri, 29 May 2026 17:08:45 +0800
Message-ID: <4CDA28DC581FDCF8+20260529090845.1696845-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: ObeNUFZ23MvRdKa/dyCJAsGBoSSBO3/M7GLGHChdQSBJHmHOQrkHkYgf
	HlxZVwCjyK8ZgpfwaN8wZ8o1J+lgtFBKydvQNFWNHmkO6jEw8vQEeRGxEz5anMa0VrWjqHH
	VtEdqUAOcw4wP1gBtf6K/dKC864h/wms7UsjuoF64TloAVseufpzhxwpAuHZIecf5GW25PM
	5ePxhpM3ehxlfYr2PwNEyE/gtW4G8xuwX8WoGJFC/f7YJePKGZtFEZKO+RKzlyxfZmv1nL8
	7re0v3bhYRvpqufr4+fwZM76fE5ZREpzfBZtYzp7dnak9PB55haxJ9fdsl1QuD+h7VUX4/g
	b5Y6UNiDgKAq6VUeopTv8Fl3KUbe3UR2zOVlOU/WAoTjb2QKEJeBTq9vdvnpnu18ILJVqNa
	6uLmzEaNlpvQV7fE1saWMT9v5pVNg9conPVVD4mvEAzxxdPzckJwhliHf4N6j7YldMHKxRF
	IEddY9ki9gwEsm0JIe4jwgVyanBJi6uhHPNmiQlfiyJud9YbU90xW/kklY/Mo1S0pk1M5O2
	Dc2rPnzInH0ojt1WkLzAu2bQbu0BW+H/M0Q3ngRCO4NM6tBe5qT5FFVdg0LAjQAhYfWIk5b
	SkuIjBoBZ6/4X/jmVn6d6+nKYI8tE6/lm+SXcFYaC6SMrd8j4RUIIWl/1pGgSZKM7CQ4UWM
	e3/VjVvLWVGUwfgIcRFSifR1kU2A65obwKNANlWSASGW9TunIbgeZidNPIu4vKGiyTwX0FO
	9x5KdJBeVomDL96O37R3/JuDZE8PvupFkiNUxUaWqQBDaAqI0eYX/ZkcvtnhUaUQU1nbHhB
	WTDn8ao+uJ3p0YTBkbhE1kJ/wTK4X/r1MjrnZToVZheqs4LcFSh9OYGIFQHQCmB+A3soBee
	vrfmssgWF85GK1lfZtlDlIIfEG2fuLGVQ2zsNt9ornqMz3KK8XcO6R24F/aGhN7Pie4iiyc
	4hK49+56fru1aekUb527oEMB8OdOdhzkyaoN/P21tGdVkZrMvq/ChieT7qwJrrKxgDW+sSJ
	U6ezKgo/KnTj60J6eO6pnvCL3sIuijsBbbilJX7EqyI9JAvTvAQpJ754waZpGcXR7AQESGW
	w==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

This series fixes memcg_path handling in DamosFilter and adds memcg
filter staging validation to the DAMON sysfs selftest.

Changes in v2:
- Use file-scoped commit subjects as suggested
- Move memcg_path readback check out of assert_filter_committed()
  into a dedicated test case at the end of main()

Cheng Nie (2):
  selftests/damon/_damon_sysfs.py: fix memcg_path assignment
  selftests/damon/sysfs.py: validate memcg_path staging readback

 tools/testing/selftests/damon/_damon_sysfs.py |  2 +-
 tools/testing/selftests/damon/sysfs.py        | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.51.0
