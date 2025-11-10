Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB452E62BE
	for <damon@lists.linux.dev>; Mon, 10 Nov 2025 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817953; cv=none; b=CSdHRtlHdZwb6cHySvaEZiGzf6XtrUA78CdIK2kjt+PpiBblUr6Cdcoage+s24yZTbMDT0J2XbMbC5uF2zgesnb8N5zON2yMWYCRCiEQ48P2gzfte8o402FP+o3fRdplMDrNHHY17efS7OFIF0RAlQm54Dg1YuyR7PJ4UrR7Phw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817953; c=relaxed/simple;
	bh=Dn/NYX3Wj4798jgUyiyxe8j2iflj/zcXoK6zpJuJGpw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YsUUZagMTr68JZfd77p+6aV95zyFzQ6ARtHqDZGxgW8At6K6ukZGyo3miOBU49oYqKe2rP5ee7pgfN14+k+hTfEW7gJU4REA84ycxLmms7z+1i72vZmhQvz4LqryTIaVnTFaEA+P5WcVweE1uINrANTFhmY2ICacHBtjQnuOVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LT41qoe8; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LT41qoe8"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-787e7aa1631so3592917b3.1
        for <damon@lists.linux.dev>; Mon, 10 Nov 2025 15:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762817951; x=1763422751; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=auOCGMGZsgkQSYvZ+oudFtHe19C6Wc96WcK7gMZx0zg=;
        b=LT41qoe8p5sL1xfgMB7+1iNQAI8gmA3l3edXU/G9iT0cwEexcLBLFQ/R08fnJ7Dc19
         vm0N0GWyIBPbo0tYmVUTPOPpA5uND0aPzHHWnLKRyAKHkfI6NlA4sWoRflO7xfHtgb5X
         FxWVVcf95A158TmNdpSm05bUOdspWVfLrXKY7UOR8Dy15MA6U6hn2NZsTZIeco2f6lSB
         VCN0j4HC9TrDOsc2cRXNsj8ZArHCNw/UODFq0ZJBsjg6xdDP9dbRPj6dyLV77G3+6qTC
         2zAGo/D1q38VvzlCcB3PJZu4p1dNFVx6OPvxLDH2mi9u+kM+rsV/lcAKRbmLgT6gNsmL
         yNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817951; x=1763422751;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auOCGMGZsgkQSYvZ+oudFtHe19C6Wc96WcK7gMZx0zg=;
        b=hzwDwEmgEnQDvxd6IMg7MRlAtxmYxg345Tz9F1xDrOQyN9CJ4/L5kdyKYOse5aKt8u
         8pn41dNANhghTTyoGBsd3yVQrk3vm3ugMUug55X5ziDWjkuVgTx88awksvqIQ79GRyq9
         7aI6GsLFuyR/W6b6+kS5EKs/1tgaXNO56yjNWGPm+cD+Wa9pHL72I3Y3fxdSc/FwwGpe
         C3aUe7vCzHdGs8IgPUKO3lL0+A/m1rVYqdi+Y9fMCRYLjojQtTkSIsOf5TteyeDcrWpy
         YP9QKu8XorSphhKx+OeAopYdF8ivpENkL9bWExbS8feCsWvpgg4RhjCxpdSnJvQY8KBm
         wIRw==
X-Forwarded-Encrypted: i=1; AJvYcCUcSux0jYZ2sg+ak0S8j82XgVBumixLryftew6g185zxh2k0wDX2Q3bUQtw72o4wb/TGQXe1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YySm3xQVfaIR+Xe/QkZsyJYKQ00GwObSGqElXdeg7qNWSMzHSyR
	01uUq8RNuByFqCBLU0pz6sOxJcLMMEZF9sWBC1vn4814JS4lh7NVrS5y6ew+THuOew==
X-Gm-Gg: ASbGncspi5oMKElQnLS+KxQAxC4VQNleBfCCZbirAQFU+0TRs5lyPr62b126n7ITV7i
	ZUxvTGhLvoTjEny9QcfHk/2TrNsvwd8HGGS+BK46Ph+2GVuOe9uFL+kO+Uo145sQhB428jL2XFA
	v2LGnxROLXEeSqmVue6eq4bI4i+LawX/LaqXwQuTbUXSQxo8ceeGLP80Ere1kcdCNoE4+uZp7zJ
	sfhoSweTE37c6mEOaYD+1NuoUoU1nMfmS53kY7hgSDPLq4gFxPOmFVmha6LJa/woMNiU9NyheBI
	2hS9JtmvLrC/Yj3nhmruB6OpiyBxWK8FQMpziEgYKXzfaAqtZNCLrDFKNB0EzjnHTAi1tjZWGBP
	rpys1J/rQl6oJJ9Rvq1nAyIRNVVS+6Bk/8QT6Gvp9NQNs2x7AqrEJv4Tw7u1cVmabnB6vmeMnkk
	ede8pyuE7oyhv18K7GRclnWrfODsQ2/nddCN5V027dHbSMGo1VbIyC5K1i2ws9fMAYh1SkY2EjN
	drO2+YWSQ==
X-Google-Smtp-Source: AGHT+IGhKzpHrBaCl8nie6rdibzD1wCPS/Sl7zTN9XwZ4g855DlbGN22SspoKQKrIKKHgp9q/nU6ag==
X-Received: by 2002:a81:8a07:0:b0:787:d107:ca88 with SMTP id 00721157ae682-7880355f82bmr9116177b3.10.1762817950151;
        Mon, 10 Nov 2025 15:39:10 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6a2947asm27792067b3.55.2025.11.10.15.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:39:09 -0800 (PST)
Date: Mon, 10 Nov 2025 15:38:55 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Janosch Frank <frankja@linux.ibm.com>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@redhat.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
    Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
    Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
    Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
    Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>, 
    Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
    Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
    Ying Huang <ying.huang@linux.alibaba.com>, 
    Alistair Popple <apopple@nvidia.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
    Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
    SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
    Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Naoya Horiguchi <nao.horiguchi@gmail.com>, 
    Pedro Falcato <pfalcato@suse.de>, 
    Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, 
    kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
In-Reply-To: <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
Message-ID: <c9e3ad0e-02ef-077c-c12c-f72057eb7817@google.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com> <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com> <5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local> <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
 <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Nov 2025, Lorenzo Stoakes wrote:
> On Mon, Nov 10, 2025 at 03:04:48AM -0800, Chris Li wrote:
> >
> > That is actually the reason to give the swap table change more
> > priority. Just saying.
> 
> I'm sorry but this is not a reasonable request. I am being as empathetic and
> kind as I can be here, but this series is proceeding without arbitrary delay.
> 
> I will do everything I can to accommodate any concerns or issues you may have
> here _within reason_ :)

But Lorenzo, have you even tested your series properly yet, with
swapping and folio migration and huge pages and tmpfs under load?
Please do.

I haven't had time to bisect yet, maybe there's nothing more needed
than a one-liner fix somewhere; but from my experience it is not yet
ready for inclusion in mm and next - it stops testing other folks' work.

I haven't tried today's v3, but from the cover letter of differences,
it didn't look like much of importance is fixed since v2: which
(after a profusion of "Bad swap offet entry 3ffffffffffff" messages,
not seen with v1, and probably not really serious) soon hits an Oops
or a BUG or something (as v1 did) - I don't have any logs or notes
to give yet, just forewarning before pursuing later in the day.

If you think v3 has fixed real crashes under load, please say so:
otherwise, I doubt it's worth Andrew hurrying to replace v2 by v3.

(Or have I got something bad in my build, and will have to apologize?
Or am I blaming your series - seems most likely - when it's actually
something else which came into mm in the last week?)

Hugh
