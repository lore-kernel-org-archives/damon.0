Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F1842A168
	for <damon@lists.linux.dev>; Fri, 31 Jul 2026 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505079; cv=none; b=Q2KIBddi7aJ+OO4cQy78+9o6z38d0+Mgi9kdn6Lo8dlYnO5ynNw0245vJ7+5mUz0Vh/TvOpdQAl0WBsvkQzC6qo/9w2yx9ECz2aOaXn2loMZDrIR/negc93/TO9a4i2SVNgyHTojhmUwirFVJ4b1Qt/oFa40v1bQ3c36dvSsbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505079; c=relaxed/simple;
	bh=oi6aO5YdOOjB5Yvtjg8wrDX+VBEC3DBUvOL+gFJ43PE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzGAKPnePP+JwL+5zZFhBwgfixZP23JyI20JLkulh7ryN/b9TvNNt/1tt+knke+mEC+sgBFXKqBsLRWqiusI/B9k0+ERUZpbQDxpKrK5IDaNOOq+zWuwMQXYv1+MHCWeNDpFs5/wZ0PXo7NACliyRU4uZdR7YKtMIOfdlnis5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id EF5564042A;
	Fri, 31 Jul 2026 13:28:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id E384117;
	Fri, 31 Jul 2026 13:27:45 +0000 (UTC)
Date: Fri, 31 Jul 2026 09:28:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, =?UTF-8?B?SsO8cmdlbiBH?=
 =?UTF-8?B?cm/Dnw==?= <jgross@suse.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Stefano Stabellini <sstabellini@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Will Deacon <will@kernel.org>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, David Hildenbrand <david@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Chris Li <chrisl@kernel.org>, Kairui
 Song <kasong@tencent.com>, Uladzislau Rezki <urezki@gmail.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, SJ
 Park <sj@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, Mike Rapoport <rppt@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, ziy@nvidia.com, pfalcato@suse.de,
 agordeev@linux.ibm.com, ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 01/11] mm: introduce hw_pte_t for PTE table storage
Message-ID: <20260731092825.36992dc9@gandalf.local.home>
In-Reply-To: <9ac33752-b587-4901-b5f2-473e573d7ede@arm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
	<20260727164715.2866609-2-usama.anjum@arm.com>
	<6xah74eadjmo2bozyr62wcxo4hhpsiufx2mshh7tztyy2dzzps@63m327m7pl5u>
	<9ac33752-b587-4901-b5f2-473e573d7ede@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bk4wphtnyr8oskxq6ok6poi7ogrp6zg4
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E384117
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188VTzKisaRifdK5JzAhtUj+tNTYkibFXo=
X-HE-Tag: 1785504465-704596
X-HE-Meta: U2FsdGVkX1+okbaURBZ2Qkn+l9IgiK40Gqe8ZThpseNdxUoxO6+yJtshZ3puroffdGsnNQX9lyVqqMfMDNqtsaiMVrZRSqd7CxcOf+tlTFcxBWBx10qhJ57MkLj8ndzBOYoA/OODEfAwWEkK0Ynym/vN8RHly0+jRGqqJSDy6cHg7VOGub/UmsJX6TfoBSOwr0+39CvO+c3eZRPTPuO9wuZjY0AitKZFKa26poYwhlLhVPb0FYC1FMbtcEIPwcv0BUAY4FqESIdzLvKNozpw1fVotcfhrX1NJojLWeahTii05xgjJv7utljWLfUJzJrqYVN7s4pCcDgRjK7TriyixEP+/JmhkJIq3qIe3n8mNyiV8HHld6EP1z7IlvkGJKR3

On Fri, 31 Jul 2026 11:19:32 +0100
Muhammad Usama Anjum <usama.anjum@arm.com> wrote:

> On 31/07/2026 6:49 am, Anshuman Khandual wrote:
> > On Mon, Jul 27, 2026 at 05:46:52PM +0100, Muhammad Usama Anjum wrote:  
> >> pte_t is used both for logical PTE values and for entries stored in a PTE
> >> table, so pte_t * does not distinguish a pointer to a copied value from a
> >> pointer to table storage.  
> > 
> > Should we rather call them as "Linux PTE" and "HW PTE" instead ?
> > 
> > Some like "Logical PTE" does not really sound very clear on what it represents.  
> Yeah, I should make distinction more visible in the cover letter.

Just as an outside observer, so take this with a grain of salt and feel
free to totally ignore it, the term "Logical" and "Physical" to me would be
that the Logical one is created by software and is not mapped to hardware,
whereas the "Physical" one would be backed by hardware.

Just using the terminology from LVM where there are Logical volumes and
Physical volumes.

But if that doesn't represent what you are trying to accomplish here, then
it is indeed not the appropriate terminology.

Again, feel free to ignore this comment, but I just wanted to give an
outside perspective of the terminology that I see.

Cheers,

-- Steve
