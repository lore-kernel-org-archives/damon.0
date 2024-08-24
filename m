Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AF39FE5
	for <damon@lists.linux.dev>; Sat, 24 Aug 2024 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724542347; cv=none; b=kOzLuA/qf55b/MQ/WN3LocrAQ1idYd7SBM3qRtAbTECXM9TlHQukYQS44MKvG+q7MK9sL4T9VqRWj0vMduYmxDfUPY8II0TaaJYfXZYr6YhpOj9bPWHDD0uVJMqirMiozSqUtl6scJClFG+LX5v9ppHgUodL0WwZAXBQbvojV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724542347; c=relaxed/simple;
	bh=T9lfm22KHIWY1lbYCOfKq8aBzxayxTnGTXykyBERHFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SibaJmhonC/d2VZj36BI8YtOJLGbkusW041q6HGT2j9pXReDudYA7fDLj2lMvn4TWFIN60co6+Fsac55rgEMB76jskob42sV9CuROJ43uQGnZBEPME/2ycq2MjX+zDvHKyik4n6fnVJvHWpRuAqESvPAF0/jNGTf1M5J05Yhoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5AvDO0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5AvDO0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878DFC32781;
	Sat, 24 Aug 2024 23:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724542346;
	bh=T9lfm22KHIWY1lbYCOfKq8aBzxayxTnGTXykyBERHFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5AvDO0aAmrNYLW47KCJk2M/+tuldad9MOB+aPhou3cWXZ+7v0WNeV3LpiQyDcUMO
	 gLfLemvM3TA7ON/F8sGlsYMtEczmXaziAdGFg3w0Jad0rV8K759YWxde9vLGR59REG
	 UHuEwhLalUSPlqQ1Iqlf7WFHupN5GPZ/78U5r8dWAmdYBYl7jigAJ/PVEWKf/2w12m
	 PFBypK3cwno6jb/TewJPsl2KGTtx2NI24pfdVBNu0xdwvlusN4RUZJDcVf+OHFEPIx
	 zSERuk06CoeduyZO6jH482wGZhwQVX9PhU6DESBCydmVW5QT6BiztgSRAaBOyuKgz/
	 knPAXpovlYAlw==
From: SeongJae Park <sj@kernel.org>
To: Yunseong Kim <yskelg@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	michel@michel-slm.name,
	damon@lists.linux.dev
Subject: Re: debian/config: add DAMON support for debian kernel
Date: Sat, 24 Aug 2024 16:32:23 -0700
Message-Id: <20240824233224.66696-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <170c9341-2cd2-48f5-97cf-66ca059a5d66@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yunseong,

On Sun, 25 Aug 2024 02:26:11 +0900 Yunseong Kim <yskelg@gmail.com> wrote:

> Hi SeongJae,
> 
> I have submitted a patch to the Debian Linux kernel team as follows:
> Link: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1172/diffs?commit_id=1c5f4aefc7791367bbf43adcd81594d1cb42aa66

Thank you very much for doing this great work and letting me know!

> 
> Please let me know if there are any additional details or improvements needed for my patch.

All looks good to me.  Nonetheless, Salvatore's comments also makes sense to
me.


Thanks,
SJ

> 
> Thank you!
> 
> Sincerely,
> Yunseong Kim
