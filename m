Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9E2AD00;
	Sat, 21 Mar 2026 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123471; cv=none; b=Tvux7hyFgkBE9E8it3acl6S6OrlnBJRAotH7SprkfOpkPbWDYQbPqI1DErb8ZAruGZDhHIUUnKjGyYGA1aYK+J9eyuiHlmOZxU7GGVFwugPtvAe48j8G8yWJm4f2iNJtHWmoQAOpNpBgqQm2gmA+yrJXuvrWYMZew/wBLbt5Two=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123471; c=relaxed/simple;
	bh=fr4AW+FIvrg9qZ2BWoFT8YfqJnfX24S5Bi94dTj4oAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFrbXPbVvXWSnhncjgISR9JSpTvTl6nGk2F98dlwzJnpXBcvfgFeyisedu/+kW2ntPZCMZw5JW+BqwL8+49TTmedW0XUxIONXT9x9ZRBpCUs/3tkNiIebBgdLTtwEG1OyDEOEiRzLOtLaOvekiDnqbtKPFPAagOJ76DrPA4oFUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql64Gy3n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql64Gy3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084AFC19421;
	Sat, 21 Mar 2026 20:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774123471;
	bh=fr4AW+FIvrg9qZ2BWoFT8YfqJnfX24S5Bi94dTj4oAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ql64Gy3nJI5rno891UT38jj+j5m6B1xazDxJIHtl1KbyKMYmU0J8Lds4xFCuCLfPb
	 yEUCFvE8Zv6pei+l0xdJcWWf/9xaxkiHA5zda5YRi8kbj+VjzPVeF2zD+AI1Og93K1
	 /1z30ioGxDRhqfqPEFDo4rPMJFSzybt8VdO80I7AKcOpE6twadRjmlnQBjXfamcgjg
	 Zahp08RiaxlkY6jywrwILGvh+if/lnYNkvivkkxtdTZE+/ZwURzhX2h/eIUa+fRKkG
	 oFNAFqRaIGOEz3AujWDXLV4yMwiUlbLeSNNemWXQ2S7ohefAWPHXkpoq05cnf5ZTkW
	 HwCJ1B5k3jfnQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review status) [PATCH v3 0/3] mm/damon/sysfs: fix memory leak and NULL dereference issues
Date: Sat, 21 Mar 2026 13:04:21 -0700
Message-ID: <20260321200422.95288-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321175427.86000-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260321175427.86000-1-sj@kernel.org

- [PATCH v3 1/3] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
  - status: Reviewed
  - review: No issues found.
- [PATCH v3 2/3] mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
  - status: Reviewed
  - review: No issues found.
- [PATCH v3 3/3] mm/damon/sysfs: check contexts->nr in repeat_call_fn
  - status: Reviewed

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260321175427.86000-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail


Thanks,
SJ
