Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994161A0BFD;
	Thu,  7 Aug 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583902; cv=none; b=TinydU51y1EmChFIyu013W3sapSQfrBebo2irpbkwEigkJVBBmM1kfPG7I2uOKUfyKhga4rlcPAlr9+RSin+uRRQmPQN4e8TK0vA22CW/gXGc6faFSBLKzAXXfXU3HMmXVpPWUmUyBWo+Erza79j5VALFOV2CXUXbKiTPcVuGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583902; c=relaxed/simple;
	bh=gZuBfBfos6lnetLDGbxB+b0JOP5wvWRXNZu2oo5TIAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpLGrqqP3l5ERa4x+263ZopdNXYBAWKxdnZB5s+hgfb8syt8J/vxYEvFyiT21QH8kjuT7B/4MbBeWp84BcORCIzqnF3RLSFMCqWbMhIT88a+YYr5uraY//BtHmfu0DU+5DRnVLhViX3zd7P0aiQiDddJs0AHtyvELo5YbnooA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNGB1fF+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNGB1fF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65E7C4CEEB;
	Thu,  7 Aug 2025 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583902;
	bh=gZuBfBfos6lnetLDGbxB+b0JOP5wvWRXNZu2oo5TIAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNGB1fF+zSer4RrcHRNtDc4XjWOFIpr9Akj8vMOxKglY64CcCS+atMiPTTfgAy1FC
	 J48secBhJX/fCDNEvnaclth1xE3MIgng0MEdsnSgKvECkDYpOufr1FlGc8HL8+IiXz
	 lA3Xl2msKWXsXMLiP3JCeXIBBu8JZsQSxEKyE7H9AYh/oHjDF6viWvutOImxa+2tHL
	 7oN3DDYzZjVYWBSq1V5c//1tRGa/qGfm4bH0o2K/YgnfVhzFxjFGmNtqDmZNiLPVcj
	 0JtJRMVklulGL0ZqzgaTK7ApGaWicj8qZyUSBOCaODq/21fOPzmLksZ4dGYyMFfgXJ
	 lUTeagY+M8Rbg==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH v2] mm/damon/core: skip needless update of damon_attrs in damon_commit_ctx()
Date: Thu,  7 Aug 2025 09:24:59 -0700
Message-Id: <20250807162459.52683-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS7mcevjD-b2vz1P+grQfffVA0bx-x5WcUQ8=JApD+UkHw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 6 Aug 2025 19:48:44 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> On Wed, Aug 6, 2025 at 7:19 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Wed,  6 Aug 2025 18:42:54 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> >
> > > From: Bijan Tabatabai <bijantabatab@micron.com>
> > >
> > > Currently, damon_commit_ctx() always calls damon_set_attrs() even if the
> > > attributes have not been changed. This can be problematic when the DAMON
> > > state is committed relatively frequently because damon_set_attrs() resets
> > > ctx->next_{aggregation,ops_update}_sis, causing aggregation and ops
> > > update operations to be needlessly delayed.
> > >
> > > This patch avoids this by only calling damon_set_attrs() in
> > > damon_commit_ctx when the attributes have been changed.
> > >
> > > Cc: Bijan Tabatabai <bijan311@gmail.com>
> >
> > Maybe above line is added by a mistake?
> 
> Sorry about that. I added it because my internship ends this week and
> wanted to make sure I get notifications on the status of this patch
> (e.g. email notifications when the patch is merged in Andrew's tree).
> If it's inappropriate I will remove it in the next version (unless
> Andrew does it himself).

I was just thinking you might not added this for a purpose.  I don't mind
adding this Cc tag.  As you may already noticed, Andrew merged this patch as is
with this Cc line, so seems Andrew also doesn't really mind, so all is good.

I hope you had a nice internship and continue seeing on the mailing lists :)

[...]
> > > +static bool damon_attrs_equals(const struct damon_attrs *attrs1,
> > > +             const struct damon_attrs *attrs2)
> > > +{
> > > +     const struct damon_intervals_goal *ig1 = &attrs1->intervals_goal;
> > > +     const struct damon_intervals_goal *ig2 = &attrs2->intervals_goal;
> > > +
> > > +     return attrs1->sample_interval == attrs2->sample_interval &&
> > > +             attrs1->aggr_interval == attrs2->aggr_interval &&
> > > +             attrs1->ops_update_interval == attrs2->ops_update_interval &&
> > > +             attrs1->min_nr_regions == attrs2->min_nr_regions &&
> > > +             attrs1->max_nr_regions == attrs2->max_nr_regions &&
> > > +             ig1->access_bp == ig2->access_bp &&
> > > +             ig1->aggrs == ig2->aggrs &&
> > > +             ig1->min_sample_us == ig2->min_sample_us &&
> > > +             ig1->max_sample_us == ig2->max_sample_us;
> > > +
> >
> > Unnecessary blank line?
> 
> Sorry for missing this!

No worry, as you may already noticed, Andrew thankfully fixed this, with a
followup fix patch[1].

So all is well :)

[...]

[1] https://lore.kernel.org/20250807033443.BD30FC4CEEB@smtp.kernel.org


Thanks,
SJ

