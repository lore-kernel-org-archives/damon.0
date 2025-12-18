Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119C2D5C76
	for <damon@lists.linux.dev>; Thu, 18 Dec 2025 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766078887; cv=none; b=M5mWKjn76B4GsbKWMtDT/8hcIqDH5muzgvqeWugzqzQsjAdhyga8cLPmV/GeHatCLWu90l9+4sxwmfv21us5UzSzBy9+Y6EfcEA7S+9puvIM1Wtw7aWaQIiPLjFrDemqLnOQ427sd6yT7eTz58q2Xnn7VaGFrIsQpAGVDyHXWdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766078887; c=relaxed/simple;
	bh=0QpK/SI+pFFJkcgrVRRUsTdd+2zpDBgpuR2wJiOTWvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akpmLNtPVsJ1OwibhVwrf4734AFAz2TRYYL8BAm1UX+Qdm4A6YMrot6Re58uPVlJuvZf4pxRYyzCPJ11gztOUN/fFcyDLICeDKp8LnfsEXhe+eCd4Sj/qY+2s1TJZJesKTshQ1AcqocMW5ZmQoj6LvXilwFW/Ig7e1rBMsJxJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 5E7CB13862C;
	Thu, 18 Dec 2025 17:28:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 54C1480009;
	Thu, 18 Dec 2025 17:28:01 +0000 (UTC)
Date: Thu, 18 Dec 2025 12:29:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] mm/damon/core: add trace point for damos stat per
 apply interval
Message-ID: <20251218122939.57963cd1@gandalf.local.home>
In-Reply-To: <20251217182915.5284d66b58ac7b744b8dcf7f@linux-foundation.org>
References: <20251217174851.28e7c4e5@gandalf.local.home>
	<20251217235219.2750-1-sj@kernel.org>
	<20251217182915.5284d66b58ac7b744b8dcf7f@linux-foundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6payrkwug7d5baq3ayi8txdc8p6zpnfs
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 54C1480009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18LqqMBRgo7b7noeiaKz6NeF6w2KmXGUdM=
X-HE-Tag: 1766078881-76418
X-HE-Meta: U2FsdGVkX18iZGF2g2mjWYfsz1mg6gAMGDTeGr7Hsp3vnmWhVpznh9bseXMrHQAyqOPNqYiM6xtd0/K3q2t/gV4U8v784Q+/xMFiDaVeuFGb/CFF67yLKAcDG1Ldu8q24u+KA99Fyno9AVE2dfUEI4+mD2LxHGm0TjlLVZODWKMRJd+MdlYWvs80EOuFEFPl4JT4fEDJeWAxirNk4g95dVwyxU2LNwEfTBJVq+roTMZinhWscIWVbxj1OQP8SRzoq0HoZF7P97TrOXQ5TVbFxM4biT/PAZpDZMFCauoVsRRCZRC3pO/ZCKMBFbXenDnXOEqSP1VTISCbP4hhVmpMFUMh7ns4N+mxc4QVE8Hn3w1Sz9RbkZ1gAC0LKI7rS7dj

On Wed, 17 Dec 2025 18:29:15 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> > > Nit, but it's been stated that strings should not be broken up because of
> > > the column limit.  
> 
> screw the rules

Heh.

> 
> > --- a/include/trace/events/damon.h
> > +++ b/include/trace/events/damon.h
> > @@ -40,9 +40,7 @@ TRACE_EVENT(damos_stat_after_apply_interval,
> >  		__entry->nr_snapshots = stat->nr_snapshots;
> >  	),
> >  
> > -	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu "
> > -			"nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu "
> > -			"qt_exceeds=%lu nr_snapshots=%lu",
> > +	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu qt_exceeds=%lu nr_snapshots=%lu",
> >  			__entry->context_idx, __entry->scheme_idx,
> >  			__entry->nr_tried, __entry->sz_tried,
> >  			__entry->nr_applied, __entry->sz_applied,  
> 
> because that's just crazy.  Let's use some judgment here!

Does it really matter? Actually, I prefer this way because it better shows
where the format ends and the parameters start. I care more about the
parameters than the format string, except to look for each "%*" value.

-- Steve
