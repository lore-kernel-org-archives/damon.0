Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A1314A79
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008660; cv=none; b=nmjgqmaY2WR4Cc5xbQd9JKavlslDMYg1GcsP9f4rk/iOmEe/YjDkuj/caDeUNOYgLMsnO/D7n2Dz0fzon93feKD4IKx8Epv8uWTsOSn0Sb5NmQtjX7CpRTq90hoa4u2cKBincsveUEYTeRUKGvcZSDDkSZGMSYR1dOots6brm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008660; c=relaxed/simple;
	bh=AOiEZS4MHz5VeUNDsjOKpnxlEfTyOIwdy0F82H2tgi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey5AWPfpAlpYWhJZiBG67/xiGvBcjezMae332GFSbQGnd9v70V6Odv4MgmoqAYdhPGhq1ZFD4n8D7h7L2KpMGk69L91FrIG0eWIIJ6q8st7e60N000JmXi2fghUmsyn/NfNl0zlDNuZO4xmk9djclSgeBxBsNsCmTT3g+NVLSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpDOoDLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpDOoDLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84D11F000E9;
	Thu,  2 Jul 2026 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008659;
	bh=3YfVzEcUkg829B5uyfjxZ2w2e7Qcu1+uMV+pJJ7jiGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lpDOoDLy1aaUtY2ZdMR3wKk1uaopv6Mu+Ue0/vIn9Iydk4MSKPPRmiZVd68G3pYXK
	 1QM9qI/Z4zE1kRZ+t/IG6a7Wz2e7oKa+S9jXc7nR6Cu627ohbHFtnJupyZ/3yaYINS
	 1zmEq7CP1uaZdYmgo7fXJU2/CJHJ1pfHaj2uynyvUKX9i9tk2014iyjMwsB7haqKp2
	 FyAvarRUEEBEYZy1nkaicCOfW/57SrZHOh/9McjWEd15KpJ3c83XZj9DUPiW102xdb
	 LsfJVphEhI4iHd3m4wuvwwNAYL3A8h9IvwAAsVJQ2Wa94g3leU0Vozdq513zMIbAWW
	 dzAL1ZaTg2WVA==
From: SJ Park <sj@kernel.org>
To: wang lian <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn
Subject: Re: [PATCH v2 0/5] mm/damon: add mTHP collapse and split actions
Date: Thu,  2 Jul 2026 09:10:48 -0700
Message-ID: <20260702161049.86172-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702065244.70360-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Jul 2026 14:52:44 +0800 wang lian <lianux.mm@gmail.com> wrote:

> From: Wang Lian <lianux.mm@gmail.com>
> 
> Hi SJ,
> 
> Thank you for correcting my misunderstanding of the versioning rules.
> This was indeed a mistake on my part, and I apologize for the confusion.
> 
> I did not intend to claim that this series is ready to be merged as-is in its current state.
> I fully expected to send this iteration as an "RFC v2" to continue our high-level architectural
> discussion, especially given the major structural pivots we made from v1
> (dropping the debugfs pipeline and shifting the telemetry to user space).
> I mistakenly incremented the version number to [PATCH v2] while
> prematurely dropping the RFC tag.

No worry, thank you for clarifying!

> 
> Since my true intention is to gather feedback on this new user-space control
> plane approach before any final merge integration, I would like to fix this immediately.
> 
> I will re-send this exact series right away with the correct tag:
> [RFC PATCH v2 0/5], following the versioning pipeline you suggested.
> 
> Please hold off on reviewing this "PATCH v2" thread;
> I will get the proper "RFC v2" into your inbox in a moment.

I got it.  I will review it soon.


Thanks,
SJ

[...]
