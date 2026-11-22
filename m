Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374696;
	b=0RXWMr8W0g14Ip61YmL3zqTAOyZL1ExoSkg0lqJGgR1GX9/VCyvJmcPY5p3qUJd+9H6B
	 pVcTbGjyUM2T3nCLytbPHXyT8zXE6bHcBTR7hs1dKVCWf/09uAklcEKuZw4zW1FnR9ZXZ
	 1iu8Jx9MvwQTAdzPTyvA8L+/8bPNTK6wOJtDGz1zIG0w/seNnP5t3czVq6dZK4PHkFP20
	 VMDCNWCAIB2MfvAfJqe9bWqeNAk+nCxBOenBJbKwaxtfHqCdI55QWcBv2EkyWabKSCMEC
	 +ycS6grZR7c0cTYf7wQ4pAZyvCRYlKlWIB5GISR8hrQzbQBJKuU6cPXE2velEGKpSfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=oGsMa7wmHQHTRJX2QekmD3Y6Ja6uGmq6iEm7evLlQd4=;
	b=gXH42Kv7aJURwU+QqOCiGNo7v7lgXLJ8LXIIdGSITAYWaK81zhilOS9pKaKlTmIr5fBt
	 mbON2mmOvb/LQG86zLR1DpBQjm2EUrJIKsP/qxRK+KmoujttJlMLeMxaTtm/Y8MeWRUGk
	 H5fJELodP3g5q0IjcQ/+fe9RoPIw3dIDL4luz4Xn34euYOvxKKDHTeRv3Xedf+IXnANQ8
	 Z0Pc71NGlNg+A2QX4SVTi0bayePV/rIOyTcYmhgETVkkJGOSfeEw1XWpVPAowwVZJ3Dz5
	 WmzNamIgFftyAa2t2hKnV7htv7VtgiXrm4sHipOB2LW3PHJtvGjweY3Um+7mYVCqKSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=K8iea7mw;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD4606A333
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 19:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFFD4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=K8iea7mw
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-94961d90b79so306566585a.3
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795374695; x=1795979495; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oGsMa7wmHQHTRJX2QekmD3Y6Ja6uGmq6iEm7evLlQd4=;
        b=K8iea7mwyVESsZ8094DXtxwvucrDg/8tk0BjHr/6M9h3+i84is1KgpFNkEGLNRXh6v
         ccGknAgcT3UL4EMlFLzALeyajVZ+5FI0baGbbdrT/x1BAwUtoKDMp1ItpWhIrYvC1sLU
         e8WPS6B3Z5WXD8nlMiUvQf7aVv6TSJQ+HXXtx51uBxEe7HgpFk6pyAA4tv2MnNYhdNWS
         fltnmRXUVOVeNjqNhRQspuRVD18NXd3zK9nSNwSNSAxqMkfSWiKofFpHnjovpg9nVw5k
         xn4zmim80Qt4xYCCtN28A+ip3Xgo5HV5zMxtjrIZ0t6aPOHt1yxWQ5pabW58YnK/9tqG
         csvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374695; x=1795979495;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGsMa7wmHQHTRJX2QekmD3Y6Ja6uGmq6iEm7evLlQd4=;
        b=LH3OXSGJD5RjpwofU5q/Xu2gjvKnQjqjB6WL8La78jpJ4PzRibUXRO3L3qZkUDB9B3
         ViiBJIEXYQZj2dZFR3hYkUUQm6P2qA6VUDSTX01kgMZxanXRVp+qB0uk5u+IVRJHkiT1
         HGKr1eXFe5o6VEj9WhtucQhN+KO2zX/vE1Tq5OCcegEa8xTXYLCASV0XhmbaIhWWC1pj
         FUUCWdi3izo8dYuygMrOxm0YyTmQvpsDWqVFTZHe0rtXMEJmAfLblsSDT1h1aUNGflmw
         kCBczYJ5SYjzFIxZFVhmTfKzF40mLmOHe35qFTd2bQ9w84CaHr+a09yRMKzYpjsWNPNF
         MOJg==
X-Forwarded-Encrypted: i=1; AL+hErHCMevT4lNN9StjxU/F0QVKh20u54tEgfEN6VqTjR++3WQWAruTRQgK0scJm9BtXeZA/VCKIw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8HngMZrfx9OaeDQ8Z17rjPh5NMpRFfNAsVlVkAQu4OG/bf5YFG
	udHtLrNCDD13ga6t6txJcoxa6SqYbYP2mCaMNt9rL2JxQZlltZOo9YaxmDNOqQOAAy0=
X-Gm-Gg: AZFdTZeInmDcY3aB/edSaTSaraBZ24dE66qVsZ5McIIC5EPRCsd1A5hgQcAKuZmww4V
	eUExdXJMvGsk0dPuHakNvSv2kw7ZpLzu2k1QvKQEaZO1NKJiDLL4MuGoOQuMlS+J+oMKNlsVKAe
	xf4efxaoAJeEuTXRJjz3QFBG7dbCZ3PuXvPzJSJEn8UvGlnM5IixoUql+fwP5P+v+MS1csuyucS
	b2zhxB3gU0I0HfFLcY/LSd9yjOxdM/bLgpiUO05/XDqdSQeOj+1Br2G37UWI/cyJguXZnNt+WBT
	3otpLzoVgGgDRMJk8c3k0//dWg2yhGo23iIEpwcFvOlhLNjNbh0D1Bf7AL+WBBQqMrSQO3ko8rM
	bsiITHTZudENESilnwDDgg655IMDfwPZ7BdljUi+YK8U5Z2nd63TVEUYSTA3zupGFWMWUE27P/g
	TBoLis2zsYtqT/ncWSagGHRDa0sA1bNhcYD+rDjbzokb0/rmxS52IeGFXnLuKYW3e80JgsANV8v
	amg+iu6zBfmStoMq8rUMzMuS59hwCDDVn7ir4d3uIuzlBPL1GmKnqcvtyB88bTo+E2/YI0VNCqF
	0HW08Zo8KYslL5UO3OdKS5MW3HkA/nUvmNqD7Iwbiu6qaFk9FiCJGpey4H96wZejbhvM/+bj+4R
	ycQTIDzc=
X-Received: by 2002:a05:620a:4727:b0:949:326f:bd2b with SMTP id af79cd13be357-949ba9aa37amr1639379885a.43.1795374694656;
        Sun, 22 Nov 2026 11:11:34 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38c903sm651828485a.19.2026.11.22.11.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:11:34 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/60] Private NUMA nodes
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: gourry@gourry.net, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, SJ Park <sj@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 Jann Horn <jannh@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Youngjun Park <youngjun.park@lge.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>, 
 Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 driver-core@lists.linux.dev, damon@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <awMdeK8O-5mffg2m@yury>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <awMdeK8O-5mffg2m@yury>
Date: Sun, 22 Nov 2026 14:11:31 -0500
Message-Id: <179537469194.412063.13456998694958645706.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 11:51 -0500, Yury Norov wrote:
> On Fri, Nov 20, 2026 at 01:08:51PM -0500, Gregory Price via B4 Relay wrote:
> > This is v6 of the Private NUMA node series. The series falls into four
> > parts, each building on the one before:
> > 
> >    1-18  mm: introduce N_MEMORY_COMMON
> 
> I walked through this part, mostly. It looks like you can substantially
> decrease the patch count if you keep N_MEMORY meaning unchanged, and
> add another type, like N_MEMORY_NOALLOC.
> 

I don't see how this would reduce the patch count substatially, you
still need to convert existing N_MEMORY users and need to differentiate
between general purpose memory nodes and private memory nodes.

And N_MEMORY_NOALLOC is not a good name.

-- 
~Gregory

