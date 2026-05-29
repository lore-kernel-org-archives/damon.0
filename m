Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238C34D3B2
	for <damon@lists.linux.dev>; Fri, 29 May 2026 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780023824; cv=none; b=FWb3OmTBgVDTlf2PJJbaZ0v28PDltXj/BmSb3KXc1s3nA3MujgCByuLY60oQuzyRGVp5RedwEd0/iX3xqPzPNZcb7Op3zV3fsvP8Ff8ATyfxJ4ZeMRpzkz3kBVO17rAwnVVJlwLtm7iiJZ4ccVanpcBnB0vz3t8+1KBFAGUy/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780023824; c=relaxed/simple;
	bh=9TLqx+AJ6QO/WhHnwYwSUxGksU1h65dvhTK7ehp1nJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SX6nVeCdwFoGqqcKdZG1XY9EXYKzIiiFBqmVk/+yunSXpJTuQasmM2+d4isC/OU8bm2EiZVQVuLS3uneCzLXOtnfHYN3QOy7w9m3vFqH8PUX//VVg8jmOmuObgk7dtiuvZ3R65+e3wDWW8//X6nLBmsFBj7Dn648kj6ErEC0YCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=kVk/euDV; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="kVk/euDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780023778;
	bh=UO25NXFfDr1JQbaCIs3jucG8rynGMrbJHIu0alItT/Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kVk/euDVNUIjx0cu5qU99sYMYIfIZZUnQCYtHPTU8cmJ2wpbFw/1E6g1xUKTiqCQR
	 TIW+z9XctVHJnGZajAM/NOjSVVrW+eMrce7NnnUMguXS3+k2/VjiHiO5BJ8/7xyRBY
	 H4w+s+fFePFG88rMsGo/+BB8MG6PTpk4Hzc0bsxA=
X-QQ-mid: zesmtpsz1t1780023764tac51051f
X-QQ-Originating-IP: MfmWebu0CGkWeYxMGyswxnR9rxACMxe/KsnSWW94zTo=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 11:02:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 772953753065975309
EX-QQ-RecipientCnt: 8
From: niecheng <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	kernel@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	niecheng1@uniontech.com,
	shuah@kernel.org
Subject: Re: [PATCH 0/2] selftests/damon: fix and validate memcg filter memcg_path handling
Date: Fri, 29 May 2026 11:02:41 +0800
Message-ID: <7C41953A77335257+20260529030241.1554009-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528143204.153713-1-sj@kernel.org>
References: <20260528143204.153713-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N9ftk+EKvgGZRNFpA5ZkVMwXFBAZUMF2lE8x9u/XxaiHv/lREbo/jm1B
	wWVf8/WOPK7qJM44SZsww58VvLgaCYqeQchTwXiWR+1i0Sa0j4iQHQyqHaaUQXyXqRXGZTs
	nB8bKXUQu+xFlZtGLfngs+2mEz6Mr1X3mpfkAJPI7zOb8nHoFN7T44/jYxsZd6NFMJao5yf
	iVX/WlvKvPO6iF556bHMQWctQc0XDsjdrIoEovOAm/JgvxYsI8kroF9vzKe9Ygl9BeCMgK8
	mJN0FviM+FekvDZFHnkwMkBVTaI7xdBaAYl4rsXBvjjj4c/uWAP6G3g+lBrXsgtmJ7bHRzn
	FtVmPrAv7cAUNoZTw6ZJWVjUMdyzcXRQ+qQ0rU/9z+qNFxZ508QQL/XYDRGSu1CMeLU0Ahi
	+4ozrwMQL4FFsF8MgRjM/CAH5p7Kqv8fmln7FvdSSPRQCKdJxhkvYAcUfXG/MPOzl2T+4lN
	KFfKiPG4HKJugXmoNPJ2tHqkdMRvKOv2uDiPYOkMMWW2uMrZUBX1DFklHnLJEKzEHkpFMkP
	GF18ELSuqAWb4AkFyz0By7hTOZAVQ66cWYIMsXDf/KuCqGtoFWbITTx4F9tjuv3D6dyj7VD
	JHGdi/EPRLmXc/zT/RqsXqXyV6D/A4qgWH/vRMh2w4a968+HTLAf/jXaMGaPZDtCYDBPs2q
	SdL63oDu3daj2V7kGfCX0SUu0t9L2RZb+q3K26pNNwIGT8RpNNRt8D9UR2lDU5n7An1/rvE
	glLxYPJ1zQ12u85bcvBnUY7Bm42LK5ZFaiv14CYXGztKfiDGyohyK1BMIGk5SZnYSTconbx
	OywVhFG3Uba/puGEMVo2l5DOX2rbL32dlqhydsZ/tIvixk/3rn9oZJHYZKEWTVsfA2DXaPD
	rndK2aDm76txi3MhT6HOKJ+2YUqpQ+wVa4GHbouvHZU7gAzqTB4JsTzRYiG+CpqhJsdt1Ug
	W7PSero523YMtAe6xeH8j5hUuwEpd2JoLuFevemAto4iSQTjJ8aZMGpFbZ+86Xc3bMi2ntT
	vfJvy6/JPTRVs4emMniRs9ktjKaIE53+Il3ZTWfUmb2HJ1Yhibthiq9V27Jpv3yUzaXnJ9/
	tohxeDTO9sEdKLYvca1FrE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

On Thu, 28 May 2026 07:32:03 -0700 SeongJae Park wrote:

> Somehow the mails of this series don't have correct 'in-reply-to' field,
> and therefore not constructed as a single thread but three individual
> threads.  Please check your setup for next time.

Sorry about that.  I will be more careful when sending patches going
forward.

> Nice catches and improvements, thank you!
>
> I left a few comments on individual pattches, though.

Thank you!  I will address the comments on the individual patches and
send a v2 soon.

Thanks,
Cheng Nie
