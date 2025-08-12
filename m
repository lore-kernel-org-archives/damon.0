Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701612FDC55
	for <damon@lists.linux.dev>; Tue, 12 Aug 2025 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021582; cv=none; b=FdEFwEOAx4V2f5W6aZVwvZxP8kVYEwE1JXebKajH/0mrSQYkiEwPVw+l6Amxcks9/yyEgp+qVxiYAsL5oA092SDbeT+/3j84s2Ck3SDIwZuae9mYXWeTE5Yx6AjNm/y5xzb2010+w5LQIMsK4RhnBk3bSHTpycG8WdNAFaOJLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021582; c=relaxed/simple;
	bh=rFjNHrdiptsoYzIPMeCnezOiQ0/fh2kvuPf4huAWgs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i1BmcsDExnfvwaPQp4jkXRoc7RuClAuHmnVWMR74ZdxVy5F72VS3cl+EhIBzwpznF3FLHypD5wpQlykJ0CD0k+H0Fb9vaQPJldNYUqvjN3WNeG/k1JkVeHkuHumqsZS8JQItQIxjQAWpebLfhptTa7+zIpm7MUPyMcWcHCntLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ0sQwZJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ0sQwZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1147FC4CEF0;
	Tue, 12 Aug 2025 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755021582;
	bh=rFjNHrdiptsoYzIPMeCnezOiQ0/fh2kvuPf4huAWgs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJ0sQwZJ7WQBftcoew9ogVjiGGqriqHFdBTvrvYnlzHh120BgkB/m4MSvvB5fcnbH
	 mIxbRuyWv7kFm0NDScia8wAAiU9GYk+9LGixpW910wSf89nJdcxj9bJq+bHgQAe01l
	 l1E5DVGziZBs/rsuccAAIM2sO3aaU3ADhgos1roNFr+q6zzkiuA2/af9WQVSJWrH98
	 ZmOi+KYb1sD/WAs7TRPoK7SlyevFyCcrM6pkJyxSiIkOW2n/+s9Y/NQ34dNRzBucOo
	 +4T6p7xI5J2GCRbWjXCzlcbPYM79xavf7iPEAxJRqtPwXv04DBMmoWdt+D4fd72sy1
	 7EH1TFULfRdSg==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/damon: fix selftests by installing drgn related script
Date: Tue, 12 Aug 2025 10:59:39 -0700
Message-Id: <20250812175939.57506-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812140046.660486-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 23:00:46 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> drgn_dump_damon_status is not installed while kselftest setup.
> It can breaks other tests which depend on drgn_dump_damon_status.
> Install drgn_dump_damon_status files to fix broken test.

This patch conflicts with the similar one from Alexandre Ghiti.  Could you
please rebase yours on top of Alexandre's one (and mention the dependency on
the comment section under '---' line), unless Andrew resolves the conflict on
his own?

> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> While setup kselftest executable environment and test this patch [1],
> I found similiar issue. Honestly, I don't know exact solution for this
> situation. So I just make a new patch. Sorry if it is wrong direction,
> then please let me know how to do next.
> 
> [1] https://lore.kernel.org/damon/20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com/

For patches that you are not really confident about and hence not insisting to
merge as-is, but wanna ask other's opinions first, you can ask questions via
plain text mails, or post patches with RFC tag on the subject.

I think this is the right patch, though.

You could refer to the TEST_FILES part of documentation[1] and "Install
selftests" section on the document for more details.

[1] https://origin.kernel.org/doc/html/latest/dev-tools/kselftest.html#contributing-new-tests-details


Thanks,
SJ

[...]
