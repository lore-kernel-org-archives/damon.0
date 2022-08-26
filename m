Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7A440C
	for <damon@lists.linux.dev>; Fri, 26 Aug 2022 17:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F61C433D7;
	Fri, 26 Aug 2022 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661534191;
	bh=iDINRuAQ4YmaJq22k2DCZ+hhEQstH3cgG8wNmEwf7RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daNeke0IhQ/wVEd02y7AL28gqaIRqwNto6VvGKWd5c4ahO5ZFNwOT2REHKTpkC550
	 KR8okkektQbiFKq7NS/VmDQmDLpEF+Fz9c8vyTrbVppRif+qF0dcSUH4ZyMJJLV5CI
	 wPmI0gOiQPtiWYeV2TEs0hacs8vNABhzIqOrnuTsgPtvGh2CEb862SW0+wXzG8qFT6
	 SbeIDmdl6Fr/NRuCHxp1RpXE0DoKHKETm0qj21GEl5IIyX8mo+gIr1JLXdNhwZ0HIF
	 lNgffucmLb4JL5s08Q93Cn/JoLbXgqJmxr/tYXIGxLRqX101R9Xlblm9H1z9b6bifB
	 kIGvWEhqEGe8g==
From: SeongJae Park <sj@kernel.org>
To: xiakaixu1987@gmail.com
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH 2/2] mm/damon/vaddr: remove comparison between mm and last_mm when checking region accesses
Date: Fri, 26 Aug 2022 17:16:29 +0000
Message-Id: <20220826171629.50210-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1661502678-19336-3-git-send-email-kaixuxia@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kaixu,

On Fri, 26 Aug 2022 16:31:18 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The damon regions that belong to the same damon target have the same
> 'struct mm_struct *mm', so it's unnecessary to compare the mm and last_mm
> objects among the damon regions in one damon target when checking accesses.

There could be multiple targets, and 'damon_va_check_accesses()' calls
'__damon_va_check_accesses()' for all the targets.  However,
'damon_va_check_accesses()' doesn't note if '__damon_va_check_accesses()' is
called with a target that same to the target it was called with for the last
time.  Hence the check is necessary.

If I'm missing something, please let me know.


Thanks,
SJ

[...]
