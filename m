Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F918DB24;
	Wed,  2 Jul 2025 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425382; cv=none; b=epS8W60z0yeXouGp89KHDQUcTsWEQu+QoF2Z4fZxC/aQCo8eQzbP2Sq6icOMOudsXaFnvBoYvrDPpbSnnAUvpHDGphQ/ar3HvqGjjokNOV7ak6VXDtP74niZpH8VVhzECfBtSBBcPp5Z8oL+AGB2weU0BpleeAR5wUe11QWb2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425382; c=relaxed/simple;
	bh=Z7EPp0HQjcqsgwPn42IotAoCEJLB9Eq5EuXBotZk5Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcTPSzF0/ox9QKPdPf+2iAwNXYVhJGxsML4a0yQFFpKuD9KXKkyIdQeRp3uCLKFrLKQcdolPYS0JvOUuNQpOwK/UVWPcA+KEaSoC5pyigxtjG5Z2S7uMZAydpBkWKbtRE9LpS12Won6NTopbuwLUI+FizwuwQFIO2wAMXGGtQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1yNF0Oq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1yNF0Oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84124C4CEEB;
	Wed,  2 Jul 2025 03:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425381;
	bh=Z7EPp0HQjcqsgwPn42IotAoCEJLB9Eq5EuXBotZk5Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1yNF0Oqdd2Wo0e10UqSe4g8qqy96uOrSENJPNZ68J9sQQmJcwf93BzTd1Z7CX1tp
	 6vwSVHQC6Z2Dyv3PLrKAOjilNtcT4w77Bg6gXekgToSRO8N2ZgvGKAEVLIfQjvKoPI
	 YheUprZ9H83kITwkoC1fmn4EkoG/FILuA2nGhkPa48HNyhNNsnLzznQ/+jNp7Ti48r
	 s8T7EymyDsOZqwu9JfYIxiyXy5SvUaYSnUQs4fI0G4dad8goFOA89s0rHk9ahaDiXm
	 IlqnOl287ZaD6A6tsq6fQN2VbZXDwaJPg6nRE6BGo0rp367d7DN6Fwx0PgAYnEk59b
	 R6dbY2iM0YgxA==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] mm/damon: add struct damos_migrate_dest
Date: Tue,  1 Jul 2025 20:02:59 -0700
Message-Id: <20250702030259.23149-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS7U9iV9K70-4J-n8pKLVBhY3Hfky4Hc3dxAbzVE1o3oeA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 1 Jul 2025 20:43:46 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> On Tue, Jul 1, 2025 at 7:25 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Tue,  1 Jul 2025 17:43:30 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> >
> > > On Sat, 21 Jun 2025 10:31:28 -0700 SeongJae Park <sj@kernel.org> wrote:
> > >
> > > > Introduce a new struct, namely damos_migrate_dest, for specifying
> > > > multiple DAMOS' migration destination nodes and their weights.
> > > >
> > > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > > ---
> > > >  include/linux/damon.h | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > > index bb58e36f019e..d60addd0b7c8 100644
> > > > --- a/include/linux/damon.h
> > > > +++ b/include/linux/damon.h
> > > > @@ -447,6 +447,22 @@ struct damos_access_pattern {
> > > >     unsigned int max_age_region;
> > > >  };
> > > >
> > > > +/**
> > > > + * struct damos_migrate_dest - Migration destination nodes and their weights.
> > >
> > > Nit: Can this be renamed to damos_migrate_dests?
> > > I think plural fits better because it stores a list of destinations.
> >
> > Makes sense, agreed.  I guess you will do that on your own when you add this on
> > your patch series?  Please let me know if you prefer different ways.  I could
> > also do that and send it again as RFC v2 of this series.
> 
> I can do this in my patch series.

Thank you!

> Would the best way for me to do that be to send modified versions of
> this patch series with my patches, or should I send one additional
> patch that just renames the struct with my patches?

I think the former (making modification in place of this patch) is better, for
people who will read the commit log in future.  Please don't forget adding your
Singed-off-by: tag, and let me know if any help is needed!


Thanks,
SJ

[...]
