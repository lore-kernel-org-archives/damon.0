Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07352E7654;
	Tue, 17 Jun 2025 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186720; cv=none; b=KXx0mEMz6YdMWOM26KN9cZCbBRzdKa0FcFgrNYrPThoxXH5xJinCOeWv2wJz24/h2PSVlvTJf1fbSkYQoAoFm9xMKGyllTt81+wEDJVHWRIsW+0r63pTvp1jaDS6pEQLGDCkxMdIOrZ3RzAImHZjbi8jew+XJXiNq/8eNweDLhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186720; c=relaxed/simple;
	bh=fathgjpu4TtjgIw+H0jxaE0vGoL3UlXM8PjYa6z7KOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfKzcQzbOHO0xs4fXE1Sm18wF3uw+2H81p1m4cCMDEQuIJ14hwIvtnsOI+W8dk5opXUSUfxjKM6crmJL77+qMbitUiUovrflSYIjT9egCa8iORsaeSAE8AN47bysb6xZK/Mlztq6Sy/TpBXBG3DWJoy0SSFCvNgsTCrMolfqJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccD4QCoD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccD4QCoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44886C4CEE3;
	Tue, 17 Jun 2025 18:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750186716;
	bh=fathgjpu4TtjgIw+H0jxaE0vGoL3UlXM8PjYa6z7KOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccD4QCoD+ZGvTQkOsHpnF3wFYsaS+2mPtPs61OKV8jkigWs0rUM4C09vZEaKfUzpy
	 QKF6B5RPPHz2PMzRcUkjrEZdEpJiTOGc3m78Bgfi2C1RE1RwUpcEjaqQyZa322wWTC
	 FvFNcQmk9ngwL3B5TTZXRe6LIC25FDLQjkEatEUIgRbWnorOmWnjnLDgyGdBn65ceK
	 b97LXzRiSQsBLGgEc6AfYS3go0wBaGsd79ZDLokUv17Gs3hjxmlo8w5mZxYWnFQeso
	 /OpZrKXVHAXaBYwm403fhWC2zziEprKcGuYgtGEy2lB9TspjDC3oLdU//v/pBTwBL9
	 8RGm8dk/yAmjg==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/4] mm/mempolicy: Expose policy_nodemask() in include/linux/mempolicy.h
Date: Tue, 17 Jun 2025 11:58:34 -0700
Message-Id: <20250617185834.58000-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS4aiyA7nXTN=QkMz4ikvf77ZaZ05ys-4N09AFLrgeS_Pw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 16 Jun 2025 17:16:16 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> Hi Gregory,
> 
> On Mon, Jun 16, 2025 at 12:43 PM Gregory Price <gourry@gourry.net> wrote:
> >
> > On Mon, Jun 16, 2025 at 09:16:55AM -0500, Bijan Tabatabai wrote:
[...]
> > Hate to interject here,

Please don't hesitate :)

[...]
> > I will just say that mempolicy is *extremely* current-task centric - and
> > very much allocation-time centric (i.e. the internal workings don't
> > really want to consider migration all that much).  You'll probably find
> > that this project requires rethinking mempolicy's external interfaces in
> > general (which is sorely needed anyway).
> >
> > I think this path to modifying mempolicy to support DAMON is a bit
> > ambitious for where mempolicy is at the moment. You may be better off
> > duplicating the interleave-weight logic and making some helper functions
> > to get the weight data, and then coming back around to generalize it
> > later.

Thank you for the nice clarification and opinion, Gregory.

> 
> This may be true, but I think I will be able to avoid a lot of this
> nastiness with what I need. I am going to try with the mempolicy
> approach for the next revision, but if I get too much resistance, I
> will probably switch to this approach.

I have no strong opinion about use of mempolicy for now, as long as mempolicy
folks are fine.

Nonetheless, I just wanted to mention Gregory's suggestion also sounds fairly
good to me.  It would avoid unnecessary coupling of the concepts of
allocation-time interleaving and after-allocation migration.  Also it feels
even more aligned with a potential future extension of this project that we
discussed[1]: letting users set multiple target nodes for
DAMOS_MIGRATE_{HOT,COLD} with arbitrary weights.

[1] https://lore.kernel.org/20250613171237.44776-1-sj@kernel.org


Thanks,
SJ

[...]
