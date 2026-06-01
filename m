Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC4358D32
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300875; cv=none; b=ZCDZTAzmU0gbh/P7g8zubKK9hExFt8cabA5pPN5KLsWJxBBLfe9ZqF0xs94RqCeAi+GFYCwvIOgozgFgTOVR84mbIoV+ZbH/lM1JfxQLN1L31B0iYydDXeqgLhajtF/oykS9aF43dfUjw65R4NkFcrx2h51GF8vt8KGI7xwqs5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300875; c=relaxed/simple;
	bh=hiGSqWdaKHtoPoaJNIXkxgho3SwPWyYReWIzlKiW4zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMkbnZGcLMj/IdgMfqKTa8jQLDe7VfYiVhBA/9L3DHrM3QdMqj4eubbAt5wnhDxiXF/YExQez6HL5PoZwKslylzhTBp9EEu0H3rwq/fsa+qLcnc15xUJbdLiIaZgf0p+ZVsFHSbju8nv+lRVYSzXMy9/Tsp0YFwTC2ardlaEw6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TQtEXInh; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TQtEXInh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780300844;
	bh=GLPi/m3WQdmSBKWIOTMLaV276KDW7VEnDXW4StkpGCQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TQtEXInhVYsWxjpKM8S4NfnNPKeIhAaYmUZ6XCvmlL/+EVEntz7hZhxfoIWbWLkj7
	 2kGWq1+LyLVp+uS9gsL/siNM/PfBo+2ERej+NhErdVWVKws8xLxt1yVuac0O9aNSb8
	 qBhmaslhRPinPRyaVvqNjRgdefq0otMNBbjN9VVk=
X-QQ-mid: esmtpsz11t1780300832t04d11e47
X-QQ-Originating-IP: 3H4NN0ARhUWAe2T8BF5/hf0ZboV2Pv02TxsvReBukVw=
Received: from PEN1097 ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 16:00:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12924311070648685928
EX-QQ-RecipientCnt: 8
From: Cheng Nie <niecheng1@uniontech.com>
To: niecheng1@uniontech.com,
	sj@kernel.org
Cc: damon@lists.linux.dev,
	kernel@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	shuah@kernel.org
Subject: Re: [PATCH v3 1/2] selftests/damon/_damon_sysfs.py: fix memcg_path assignment
Date: Mon,  1 Jun 2026 16:00:28 +0800
Message-ID: <79F7B6B20207E976+20260601080028.217269-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <A374E0020B17741D+20260601074408.204630-1-niecheng1@uniontech.com>
References: <A374E0020B17741D+20260601074408.204630-1-niecheng1@uniontech.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: M6Wwv1ws7JqNANWwCaBdpNz2/EBKknL+pDZ753tLdW7HAv6qihpgYXmT
	9bwF42I5XLnqWjkPRqZlx/5E9Wky8kMLW2Xyo38LFSzrPwZy3Vl718axHnGpaT2aFrbXOjC
	UulwIKA1hs3Pfp+j0qqaFR+VKv+HpAaFnhJ5xOjwBx7myg9NHtrKRHIZRBw+AZ1vuTL04+N
	8ykAJwyLflb56iNSYED5r3NnsO1AIo0QlsnZHjVm6+bocuULUvvXhS1eeXCsDPJUdYzzg1J
	6m53nERB6Bj0zaqoipX20oLwJ7tyWEUCcxkvofQxm822HvhTpL7aYTXtjuBgC1hT/WlFmda
	xTl2xmE+irA2QBRmWeZv0463eBuTG1fx9hWNk2EOZXdre2E8779d82g7Yf2n4gpG8NB8TYM
	cgOIdYoqSx/qLkdyggICyvNE30ts2XreWq56VzIJbSmre1Y/hG6oHGYWyyEt62kpNPBs7ao
	8xm6hHkEGQZ1y0JmMiqEV8wXFnbtKRikG+yVP4oet9aHCPBrfJF3oU/3seuA/DLFh970Tlq
	X/lmTOKTVTH/GnpUKxKHK2hjDDaRFVk1Sb2Sk1qJ1luiadfo9MiwRREMka6jGvtJP/1vf7k
	E0A7HKi337iNmB9Q49+2j2suwcKq8+pfAEbKEt5tUWUH05i/0KqeOBKIWMlxTJ5dZ7C6umc
	Cqo9SosXOJrEPKpoP5Qz3aKXZXRwbHd9Z8CfciBsrUfvN5GfDp2SURueqR+38yX60+riPq0
	jYjFcZjj6F4xZH1ad2NEzPAzrKKDHmZsgL835SDN8XAq9UTyKbXbdD5WK/VWbOnxFtx61rp
	2l2qeiP2gP4C3QBHLr1mSdf+M2gVjSFtZKXNWp/mekFt0xJtYWYKq3p3sTsPHTexbzn1z2T
	VAP4vwG1hH+gaI/K9DNBiLiTN9UeAQq5yktqvyq+kxsOLeblkKMM6YoPj3bIH36ZntKrXKH
	6a2fm+bg2aOUCqakV/D7t+gyzf5UqRv25D0MPD9CQe7WyfPslliJh7qzeHOqJc78sJfmWg9
	6XzrloCMqjvpJ6KD/DcOR/M0spbGXB1KZm8btR6C+wBNSZBcURfRi4LH2/Y7feoCde6wEy/
	Vhj1Co2jbvLVe2/7otF34LnvX9EVwi4wu5DNTOg5MDG
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Hi SJ,

Sorry for the noise.  This patch email was sent by mistake with incorrect
send-email settings (wrong To and In-Reply-To).  Please ignore this message
and any other duplicate v3 patch emails outside the cover thread below.

The correct v3 series is here:

  https://lore.kernel.org/damon/D4787203018006D6+20260601073635.200015-1-niecheng1@uniontech.com/T/

Please use the latest [PATCH v3 1/2] and [PATCH v3 2/2] in that thread.

Sorry for the confusion.

Thanks,
Cheng Nie
