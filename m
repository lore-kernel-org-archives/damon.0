Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81A70808;
	Wed, 31 Dec 2025 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767157303; cv=none; b=Li71tov8vJtCqr/k2eBX7w119vjo6y8IpD5KBy012u8aUyDsepZzN5MDbd0ST+g2H12has/aGf93w8OgU3rHD3VrxGATOikfQnmEXnhKrsmRd2FDAcWVl3OgEaDj/lpt6sgaRqG+NZzPHlc6VMmFk8yWeflNgrvkXdT0I6fJdhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767157303; c=relaxed/simple;
	bh=ejr65dPwB1igdyhJuOkgkDHxjUZatDO/Hs5Knw9TBVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdO99LL087JS9JhNE6wD9jK/e1aILf2NWWkmefZZsqfYD9xo8q8YkZRuoIP+Mv+D65osIBqw+TUt4UONpCSHGEhC4xgD8gGXAHC2aKDllf0rMGT7EAqFm3q69SY3CLQZna30gga/yv3A3+TD5J++unVRi2ajOaedSesYMDII8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgsqbEFJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgsqbEFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B9BC116B1;
	Wed, 31 Dec 2025 05:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767157303;
	bh=ejr65dPwB1igdyhJuOkgkDHxjUZatDO/Hs5Knw9TBVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgsqbEFJMphC0NO85sA0hK3dRmiHLIn/+JEvZ3VNUypK1t9a27aQIRKldS2AIQWG/
	 xTmKizpo38V3KcPQlAv0MBFChHJj/8tvP3MjynQHl/gUa64CqW04pAZcWQIpdtGdi9
	 yZXTEiFhaFLoHiHajZsYX9m/HefGnzDlKh0s9ccLHTzs2TSQubV2ClWlJQqvYm6omo
	 JCncODigKLKHXsclYZtW7jiKhNyZi1NXfPtqvC//DE8IflhspoIyMqApPhVQr//Uqa
	 2BjTHt1tIBdlDJ1onQo57zNspzMUI00kkpVTWvM+Ox9sT9gqHCI6QKLYUz37seWjI8
	 Euakf0dOf3yIA==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	wangkefeng.wang@huawei.com,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
Date: Tue, 30 Dec 2025 21:01:37 -0800
Message-ID: <20251231050138.77727-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4b367446-2248-4936-99b6-e9ee93298eb5@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Dec 2025 12:02:31 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 12/29/2025 6:22 PM, SeongJae Park wrote:
> > Hello Asier,
> 
> Hi SeongJae,
> 
> > 
> > Thank you for sending this patch!
> > 
> > On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> This is a minor patch set for a call_controls_lock synchronization improvement.
> > 
> > Please break description lines to not exceed 75 characters per line.
> > 
> >>
> >> Spinlocks are faster than mutexes, even when the mutex takes the fast
> >> path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.
> > 
> > But call_controls_lock is not being used on performance critical part.
> > Actually, most of DAMON code is not performance critical.  I really appreciate
> > your patch, but I have to say I don't think this change is really needed now.
> > Please let me know if I'm missing something.
> 
> I was just reviewing the code and I noticed this. Yes, you are right, the performance 
> is not critical.

Thank you for flexibly accepting my humble opinion.

> 
> >>
> >> Initial benchmarking shows the following results
> >>
> >>
> >> # bpftrace -e 'kprobe:kdamond_call { @start[tid] = nsecs; }
> > 
> > Commit log shouldn't start with '#'.  Please consider indenting the above
> > command and below outputs of it.
> > 
> > 
> > Thanks,
> > SJ
> > 
> > [...]
> > 
> 
> Thanks a lot for the review!

My pleasure!  Looking forward to your next patch :)


Thanks,
SJ

[...]
