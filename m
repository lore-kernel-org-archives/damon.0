Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F04AED7;
	Sun, 12 May 2024 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715536850; cv=none; b=slnY30c4iEmjzyKkwNHjESCq7cAymtn0WffawOLA3H5Jv+BzJuNlqUGib24+OY7F0aBYBdqscm9atjl7rwQz7eBChwQ9/EFkqYxEkzPHpywlzzK4Yi0cZp3m+L1Ku6oIL0ZtVBdHwDVbuXfL4u5VDfAVHTVkO19yICwmagkWCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715536850; c=relaxed/simple;
	bh=qpiFUol8P0zNhvUFVoN6iW1e1aeFqNHpooxXO9xEl04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3io7xhNiKtUR28p7MbImg6xx3jAGvjtzCItlXH/C8KO2fJVGxD+c7cjI4RH7yKq4YWjt5RN5c8jiG3ofQ60QI2xichtQ9WEbpRgRnjOZK4GrGgfRtWu14dkbxs1kr+keCTuFd+1222uDGxw+2OZqviQubtHwzhkeeuYlUhgViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFvWblmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFvWblmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546D0C116B1;
	Sun, 12 May 2024 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715536850;
	bh=qpiFUol8P0zNhvUFVoN6iW1e1aeFqNHpooxXO9xEl04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFvWblmkErJHGxYytEKfxEysBzLmbIM1r9/FpIWdKSUtJmY/U2D408Fqajysf+2wy
	 1OEGeICXddpUU7816eua76jSCGLa3khOL4jBE5/hV2RHLXU4IyqDGvxmlkTDMHdYJJ
	 dJu6exgqHN0EpZKLZ08wO/hmB9yhwJFNnAjGCrRMnnNByWIBs9TPWR2W1Un6aJdRSO
	 v3gh9cJoOeUO1XTGtlrZa5ZZEvzjZISkE64pDrJfRwseEA6JBmMmPNv9w5J51KMFPb
	 lIDka2y6oiq2EFiW8BPHmL+BegmoiZ+kByDB5JQiFD67l1COYYV1BGb7WCna3hUfgW
	 hsTuaOIzCGm6A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 1/7] mm/damon/paddr: refactor DAMOS_PAGEOUT with migration_mode
Date: Sun, 12 May 2024 11:00:44 -0700
Message-Id: <20240512180044.76086-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240511201617.292811-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 11 May 2024 13:16:17 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Fri,  5 Apr 2024 12:19:07 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Fri,  5 Apr 2024 15:08:50 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > 
> > > This is a preparation patch that introduces migration modes.
> > > 
> > > The damon_pa_pageout is renamed to damon_pa_migrate and it receives an
> > > extra argument for migration_mode.
> > 
> > I personally think keeping damon_pa_pageout() as is and adding a new function
> > (damon_pa_migrate()) with some duplicated code is also ok, but this approach
> > also looks fine to me.  So I have no strong opinion here, but just letting you
> > know I would have no objection at both approaches.
> 
> Meanwhile, we added one more logic in damon_pa_pageout() for doing page
> idleness double check on its own[1].  It makes reusing damon_pa_pageout() for
> multiple reason a bit complex.  I think the complexity added a problem in this
> patch that I also missed before due to the complexity.  Show below comment in
> line.  Hence now I think it would be better to do the suggested way.
> 
> If we use the approach, this patch is no more necessary, and therefore can be
> dropped.
> 
> [1] https://lore.kernel.org/20240426195247.100306-1-sj@kernel.org

I updated this patchset to address comments on this thread, and posted it as
RFC patchset v4 on behalf of Honggyu under his approval:
https://lore.kernel.org/20240512175447.75943-1-sj@kernel.org


Thanks,
SJ

[...]
