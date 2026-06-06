Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F334071D5;
	Sat,  6 Jun 2026 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704932; cv=none; b=cXp2TA5y/njiP1zJ9TajuCA/TQrXXlgpiDf97UOApvmhc53DEXbEzUW/sDUU+k6apuLXHM9btEOVSzXLaqvUHmj0O1DYtAFp5k3gfewp2ugi0RbscRnzZYsWUTDYFz6SIWWeT/5Yu8+XbeKkMDP3MkOzo2HxHD0E4F9Ih+zH1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704932; c=relaxed/simple;
	bh=c2FwY9h+GDf00kPiRlQWL1xylu+ris8uGcC2jT3PznA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OikOZusi7ZVgLt3NW9n46/GBGNi9+4lJL+zMLD9SKdtc9ZCIDY+DP+3wGZvWh9SCTPoh0U09DDyqNLjs1OadyKuKwpjudTbQCmr5I4DBHi2w65JOvS9IS7DmC+ZZ3dPYEew8GKIDoGvfUbbT4FaIfhyECwoWf+HmR1BZlbqYtxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzsbv/Is; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzsbv/Is"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49B01F00893;
	Sat,  6 Jun 2026 00:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780704931;
	bh=q21/N23xnTWt5KQrxm+P61rbnPXycWl3dQ/AY35648Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bzsbv/IsDaorrjh/e4WXwy/3FE0jWFrn4HX7GRVwyLx4TLK8be330nHKnmR93fwCE
	 6KD0jq9N9i2m40MWCuSQsWrt2hNoLur9q2KXK0wfDvxb83y64je9NJWJ6vt7iZzZvA
	 wwrHVUCGgb/sE5U4c6v89Swb0KIHJHgCB3i0lCZZiN81+gQqfM4gY6SSUhAQXapuyX
	 rcaNrGG9+RuPQ3dG+7YBduaFMWy5wG3WBOqdHvVOjEGJfUBkEOaYI3mWdNVMYP+DNN
	 FxsyGrRMagvzLKWGLKdqgkj+rMJEjJJDraAJKtVxzpbenD4Ex8J9WT2REhPNQms+SM
	 SBux2YqJzYC8Q==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/4] mm/damon: Generalize ctx_target creation for damon_ops_id and add vaddr support
Date: Fri,  5 Jun 2026 17:15:23 -0700
Message-ID: <20260606001523.88590-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a9269eaf-a567-4dfe-99a3-cee4b13946de@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 5 Jun 2026 14:13:01 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 6/5/2026 3:50 AM, SeongJae Park wrote:
> > On Thu, 4 Jun 2026 15:03:35 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> This patch adds a new function damon_modules_new_vaddr_ctx_target.
> >> Since ctx_target creation for vaddr and paddr is almost
> >> identical, the logic is extracted to a new function,
> >> damon_modules_new_ctx_target, and vaddr and paddr functions
> >> are left just as interfaces.
> >>
> >> This change was suggested earlier1 and it is needed to allow
> >> developers to create DAMON modules that use DAMON_OPS_VADDR targets.
> >>
> >> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >> Suggested-by: SeongJae Park <sj@kernel.org>
> >> ---
> >>  mm/damon/modules-common.c | 31 +++++++++++++++++++++++++++----
> >>  mm/damon/modules-common.h |  3 +++
> >>  2 files changed, 30 insertions(+), 4 deletions(-)
> > 
> > This change is for the sample module that will be introduced by the third patch
> > of this series, right?
> > 
> > I'd like sample modules to be simple and completely isolated under sample/
> > directory.  Is this change really required for the sammple directory?  If not,
> > could we please drop this patch?
> So, just create the context manually in the module without a new
> damon_modules_new_vaddr_ctx_target interface?> 

Yes.


Thanks,
SJ

[...]
