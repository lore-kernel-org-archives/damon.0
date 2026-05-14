Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B9D531;
	Thu, 14 May 2026 23:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802357; cv=none; b=HuGepWg9h9b6RedmP86O+0Bmm6AFcPB35hFOALkg6L7muudzetvG/fker4ndzkVO4GOwe/apMoWWkl8Wce1y4h6T1qQ5QFsYe8AtPvm68Vz4Tq7Q1kqU/V+mN3u4BqP4tbvOKIRlKEqxzI1lZyk5dT5xT6oBIujnb5y+PGy4Yqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802357; c=relaxed/simple;
	bh=bsHRd/vwPkavOuwpmuRZxnPcYjM2v93dFITdwXzhbuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVbDqP7QJHGrza7OKIsqDsRpysTC/iP7mEVqK8L7vSetQC/CkfEjtlieKDs79MquaDz40CUGRIdhPLwhDeWOquAp2TqOKcV0vUB+QpQ0fWZO93I3sV1vrtvWpf6GmSXXpcYTSc7FsbKe7rsk7L3sV6KfmlhqGtvk5h3ml8s5DOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RedXKoAv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RedXKoAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83479C2BCB3;
	Thu, 14 May 2026 23:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778802356;
	bh=bsHRd/vwPkavOuwpmuRZxnPcYjM2v93dFITdwXzhbuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RedXKoAvi8JZueyphlsZY/3r+qSX8OBulmGj2OvNmTJl0Guu49m0dw12EaEmP+/Bl
	 jzQ3eR/yz8IzZKawJNDOgt8GGUI5XVg3t4MffMaS2amLkfJNL1mvcdAbkH6QkuGEX6
	 aPLIrEa3vUIW2uF3IGFWsXFGcM4SJj4enGEXwdaMfxbAqEJvk0M7/xfQMMog0rtaxP
	 x0rE/A/aUyEItcBFmyPQha+0mkNzhiGmEZ6VIgWhQSMmVqgD4nmS8Y7bL8wbvzT1CI
	 r1E4FiflOgA/1RbL1O/IylOUx735eCnuXKxXiE+MINFbm5bqjaYOMrhkHvR+oKH5o2
	 9RxqkyxQjItZA==
From: SeongJae Park <sj@kernel.org>
To: niecheng <niecheng1@uniontech.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com
Subject: Re: [PATCH] mm/damon/core: clarify next_intervals_tune_sis update path
Date: Thu, 14 May 2026 16:45:09 -0700
Message-ID: <20260514234510.123948-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <D3B0C1F5BB6ADCE4+20260514163751.3399513-1-niecheng1@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello nicheng,


On Fri, 15 May 2026 00:37:51 +0800 niecheng <niecheng1@uniontech.com> wrote:

> damon_set_attrs() updates next_aggregation_sis and
> next_ops_update_sis for online attrs updates, but it does not update
> next_intervals_tune_sis there.
> 
> This can look like a missing update when reading damon_set_attrs()
> alone, while next_intervals_tune_sis is actually updated in
> kdamond_fn().
> 
> Add a short comment to make this explicit.

Thank you for making the code easier to read!

> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Link: https://lore.kernel.org/linux-mm/20260514144102.120203-1-sj@kernel.org/

So this is a second version of the patch on the above link, right?  From the
next time, please add the version on the subject prefix, e.g., [PATCH v2].
Also, from the next time,please post a new version of patches as new thread,
rather than a reply to the previous version, with the revision changelog with
the link to the previous version [1] on the commentary area.

> Signed-off-by: niecheng <niecheng1@uniontech.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

[1] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ

[...]
