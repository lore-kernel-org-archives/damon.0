Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E438E8D4
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415287; cv=none; b=f/ZaACkcUIihZlloRKhj5HBDAUmEISH/SSFlJ7//uhqsc+/yAX9qV154gZx5AeBXKfBveUKbq8hR1GCaYFxxsP+uIKtIV9HctX+dGSt6WHDxViuOGz/HWuebYPB4Hfif8SYpyF8LaOQxayc1/R7zoZmBdDxeCnVkaZUTznrPy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415287; c=relaxed/simple;
	bh=C0C4IH830hmQ7uGSsM1fQXuo43b8aFwf8//gFJZFkO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDcvBVB1l1pEPRB8che7xSaF2C6mqIEc05XuOQ9R9LAruih9tfsSxOYBUBiuhlA+nCT+Eau8O3IwbwpbFBvWezOa1PpB2MvAxwAZChQyZfBF6r1NSMNogWk2pgze2zBDMD4hd1bam9cSMYo5YhhNlKvLgGKAa91+iEP3g1O1o78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0QmhPMcU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4+urEO7G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B0UgCNFj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0reR7q/r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0QmhPMcU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4+urEO7G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B0UgCNFj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0reR7q/r"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9D39758AB;
	Tue,  7 Jul 2026 09:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783415284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHv4kahBeNrmd8/qDWoJFBecT8vqZhiAuIMjLHee1tY=;
	b=0QmhPMcUlwUDUqtm6987poHzhjQ8wXsPRNp0+n13eKN3ld5nfEJgqx9qWJ0BO2OcvPyihX
	Y5LZcYYUizapk2mYXJA2Noo30bt2T7tP0lLiSJJdfrwRsfq9FO1jV49favkoCXnL2k0e8g
	52OmzxBlNN+PCDx+4Z//UQDjp03W0zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783415284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHv4kahBeNrmd8/qDWoJFBecT8vqZhiAuIMjLHee1tY=;
	b=4+urEO7GVf92z+DsHyXVZab1QdBA96SV/AA0Osw+aQt51NWZV2NXLRds473Iu1ASwtgwGI
	yay7jI/HYfqk7DCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783415283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHv4kahBeNrmd8/qDWoJFBecT8vqZhiAuIMjLHee1tY=;
	b=B0UgCNFjqqBLJx83yWDQjZgu5HLThcnZsNyKZs2umLaATtGQ2G6EvKRzMDn8C17Sq8DWVc
	m6giXIX97v+3xoGls6zmGqh2aioRQdV+6LD0KU4hPkzZ4yRw5NRnIFunKM8sMsHBIWjhTB
	LAE83bdJ0+M130kHjXQ4LTSK8gE+6Ys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783415283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHv4kahBeNrmd8/qDWoJFBecT8vqZhiAuIMjLHee1tY=;
	b=0reR7q/r1BjXy9ySDjT5PUxjfbC7i7JijwrJKygtr6MhGaL8F22+rXsYWeATnSPJH/xhI7
	yq0sfLIvmjkR5iDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F97D779AE;
	Tue,  7 Jul 2026 09:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rPc4CPDBTGo6LAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 07 Jul 2026 09:08:00 +0000
Date: Tue, 7 Jul 2026 10:07:58 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: wangtao <tao.wangtao@honor.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"willy@infradead.org" <willy@infradead.org>, "sj@kernel.org" <sj@kernel.org>, 
	"kees@kernel.org" <kees@kernel.org>, "luizcap@redhat.com" <luizcap@redhat.com>, 
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>, 
	"ljs@kernel.org" <ljs@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"liam@infradead.org" <liam@infradead.org>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>, 
	"riel@surriel.com" <riel@surriel.com>, "harry@kernel.org" <harry@kernel.org>, 
	"jannh@google.com" <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"ziy@nvidia.com" <ziy@nvidia.com>, "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, 
	"npache@redhat.com" <npache@redhat.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "baohua@kernel.org" <baohua@kernel.org>, 
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"baoquan.he@linux.dev" <baoquan.he@linux.dev>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"matthew.brost@intel.com" <matthew.brost@intel.com>, "joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, 
	"rakie.kim@sk.com" <rakie.kim@sk.com>, "byungchul@sk.com" <byungchul@sk.com>, 
	"gourry@gourry.net" <gourry@gourry.net>, "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, 
	"apopple@nvidia.com" <apopple@nvidia.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "jparsana@google.com" <jparsana@google.com>, 
	"dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>, 
	wangzicheng <wangzicheng@honor.com>
Subject: Re: [RFC PATCH v2 00/13] mm: rework anon_vma and remove
 anon_vma_chain
Message-ID: <aky_oySdi6YhtJWW@pedro-suse.lan>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <08c001ab-320f-4676-830b-8e4ba6a05dee@kernel.org>
 <b00a03d62c53430ca22b3f3c5e5327b5@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b00a03d62c53430ca22b3f3c5e5327b5@honor.com>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[pedro-suse.lan:mid,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,arm.com,redhat.com,alien8.de,linux.intel.com,infradead.org,cmss.chinamobile.com,zytor.com,google.com,suse.com,suse.cz,surriel.com,ziepe.ca,nvidia.com,linux.alibaba.com,linux.dev,zte.com.cn,gmail.com,intel.com,sk.com,gourry.net,lists.infradead.org,vger.kernel.org,kvack.org,lists.linux.dev,honor.com];
	R_RATELIMIT(0.00)[to_ip_from(RL3mhzhn45zpqpmgqn4z7synfm)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Tue, Jul 07, 2026 at 08:21:24AM +0000, wangtao wrote:
> > 
> > On 7/7/26 08:32, tao wrote:
> > > Hi all,
> > >
> > > Since v1 was relatively complex and difficult to extend, this version
> > > adopts a simpler anon_vma implementation approach.
> > 
> > I really hate to repeat myself, but you seemed to have missed my main point
> > [1]
> > 
> I saw it, and I’ve waited for a while as well.

what?

A good part of software engineering (and FOSS in general) is collaboration.
People have their own work responsibilities & personal lives. If you had
questions, you could've raised them on-list or directly to Lorenzo and
could've helped him drive it forward (which he is, and he's posting careful
precursor patches).

> 
> If there are technical issues, please point them out directly.
> Or is this simply how technical discussions are usually conducted in the Linux community or the mm subsystem?

There is no technical discussion to be had. Lorenzo is doing a large,
careful rework of anon rmap (and rmap in general). You don't get to override
his work because you decided to ignore the "community outreach and
collaboration" step.

-- 
Pedro
