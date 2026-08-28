Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4786341;
	Fri, 28 Aug 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942068; cv=none; b=ktwUBKe+udCw992lQMc6zJuXa394ZI1V8rd4c00HovdteJsk+l/I3aqtO9ouhJrz3AvoISqNZMJys/hHuuOQrcPqiLzWJRwOWjbDdUAOys07ZPqqqpGaUgaShfoZla15qB74ux94CBCGomb2YEclO3L0DWk9XEekGYlX9MxC0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942068; c=relaxed/simple;
	bh=KdfzTLVYQW6tHjMYF12HWIyiWUSMgrVtYrY5MCUObm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ev6SXk4c41o6deDT9MNcJv8ZIAzD3DgmB1DxOxVv42zZUt8MRCVpBl74z9ZMGNCMsCe7XECN02CZVEmEokMvluHWyxEDVYg/79xR14PscezlrxpPDPLb5OzBTcdkLSA1RFz+t0AZAodT7mteVA0h/xuWL8kQ1xVw4RVLxS6Qbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRrIQfmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRrIQfmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285DA1F000E9;
	Fri, 28 Aug 2026 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787942066;
	bh=86nATO2Tu0jZBpxgXv1REoJRi08xat/kpDwIpazzsWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lRrIQfmmFNi3qSzFzLyCewXV9zO6hUZ9/OOOVsBgv/mM6fuYWRhmreKto9IJrmla5
	 72ggZXs9XywE0ibXRwVDhsDD6zZZN3w7VXfHYuUKH1AYexz52ME5S/RLiYxIWeldiP
	 teUGn++zmZeGJjfqpoIXBtA5AOYgY9nPlsz5mzphQ66nMlYhNVZvnBX+vRlvtMRq1y
	 len7ZKmo9YL1V8WsZJfdsinMXp1p3iN3UCZiWZ652pCkr92cpNkLkLpb22zSCpOeHr
	 PIKQqXM67MeO05YnS3o9LU2yNJ1rEma5pJZihnu4rVke8dXXkCped0no/iKf5p9mKy
	 hqUfhguEvf2/w==
From: SJ Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 25/37] Docs/admin-guide/mm/damon/usage: document sample filters dir
Date: Fri, 28 Aug 2026 11:34:17 -0700
Message-ID: <20260828183419.70652-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <88698ac7-3a60-45b7-908a-7f1521c021aa@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 12:13:20 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> On 12/8/25 2:29 PM, SeongJae Park wrote:
> > Update DAMON usage document for the added DAMON sysfs files for
> > installing and setting the access sample results filtering.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  Documentation/admin-guide/mm/damon/usage.rst | 25 +++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > index 897a89950351..365a4548a5ba 100644
> > --- a/Documentation/admin-guide/mm/damon/usage.rst
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> > @@ -66,6 +66,8 @@ comma (",").
> >      │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
> >      │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
> >      │ │ │ │ │ │ sample/primitives/page_table,page_faults
> > +    │ │ │ │ │ │ sample/filters/nr_filters
> > +    │ │ │ │ │ │ │ 0/type,matching,allow,cpumask
> >      │ │ │ │ │ │ nr_regions/min,max
> >      │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
> >      │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target,obsolete_target
> > @@ -233,7 +235,8 @@ writing to and rading from the files.
> >  For more details about the intervals and monitoring regions range, please refer
> >  to the Design document (:doc:`/mm/damon/design`).
> >  
> > -Under ``sample`` directory, a directory, ``primitives`` exists.
> > +Under ``sample`` directory, two directories, ``primitives`` and ``filters``
> > +exist.
> >  
> >  contexts/<N>/monitoring_attrs/sample/primitives/
> >  ------------------------------------------------
> > @@ -245,6 +248,26 @@ to these files, users can select whether to use the :ref:`page table accessed
> >  bit <damon_design_pte_accessed_bit_access_check>` and :ref:`page fault events
> >  <damon_design_page_fault_access_check>`, respectively.
> >  
> > +contexts/<N>/monitoring_attrs/sample/filters/
> > +---------------------------------------------
> > +
> > +This directory is for control of the :ref:`access sampling results filters
> > +<damon_design_sampling_results_filters>`.  At the beginning, this directory has
> > +only one file, ``nr_filters``.  Writing a positive integer ``<n>`` to the file
> > +generates directories of the number, named ``0`` to ``<n - 1>``.  The generated
> > +directories represent the sampling result filters to install to the DAMON
> > +context, in the order of the directory names.  Writing ``0`` to ``nr_filters``
> > +removes the directories.
> > +
> > +Under the individual filter directory, five files, ``type``, ``matching``,
> 
> nitpick: "four files" in this patch and "five files" in patch #32.

Thank you for reviewing, Zenghui!  I will keep this in my mind when I write a
successor [1] of this.

[1] https://lore.kernel.org/all/20260525225208.1179-1-sj@kernel.org/


Thanks,
SJ

[...]
