Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1440E26ED51
	for <damon@lists.linux.dev>; Wed,  5 Nov 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366613; cv=none; b=BSDKSgDT+lzYtba8HK8NDFH+cOu/gO0VGptdh49ucdST/c26Sk+KbNMJysLSm9zWfWxcUbKMacQbJmlPdd3w28H4lHExddeIJxJCpf74WXOzSLZNJqgQ4g/kygdXkZU2n9CcrQW9tzzYkNK2wI2lYX0kcUuDnwrpcCnyaeGvYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366613; c=relaxed/simple;
	bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pobWy9fyZKGAHCO03EzPtLimeG5oJXM6bJj1zDPvk4rbas8o0AOvOyrn2pHq0bjRw/6AdESLv56AJpuOnOC1JOaj3Myz0ybdVjy5m/6+hc6oxdZg2ivi5i1I8ix8mYD/VRqx3xfH0Yqhz0+EPExPqShAMl2l8iKsUuX3K0cVWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B43fsrjf; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B43fsrjf"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-85a4ceb4c3dso10834785a.3
        for <damon@lists.linux.dev>; Wed, 05 Nov 2025 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762366611; x=1762971411; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
        b=B43fsrjf1erjf19ng9AkorTzlH32i3K3rHTI+gxS9uIfhV93IT2nRatPcd8wS9Q8xp
         8FF56zT90SWxKxNPESGbu/nykdisy5p91NCQRdsg6hdZXTY1sZWKZtCTtDmzQ7M7uhb9
         yrpyamw6Et6r8L/sGQ3MUwgL1leiGRfK2JmsYWtH3b4b1ffy2tvFlZ7EnjX0OQOPlu1/
         5B7ZA5MsH4z3zcL2TpOzocmjHeKS4bnncZv3xsh2e8eYT1KUGgIjZmiLiKtTdXvNrOoc
         m8FfKtkYG+Ti4hY0KsCPjFDq6vf199P7dpZSZgecMsOqHRZ/+PR2NO8nSYZxodjpCyZ3
         z50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762366611; x=1762971411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
        b=wAbXSZeqiPtH5lYpmYSZYNb4jnX5+7cgvca05wVxQvcQnBVdzvdOVEVopViQ4cde/t
         gW2cPUkThPoj4q18bfApfDzWgMX5UtQVqoQxSQN+VsyG2NUA/Y/yvm6tRbk3LkwSsUVz
         gSpFu99C5BsaovqmgDzUuKESum/RLNbymj09eMFA07VmVyJsC7D+F+cJ9zOcEVVc82f4
         kKKMFCdYM0xa1PMgKMYKwSlJlc91KvjmQCP8VWC0bmF1GsnbSy8iHgcQjraw2xpkUd3f
         tcbav8LCBeoX91mQHzZcjC9iQrNy6E0encQhZtplb0KFtWM9arKG4J88N4MgOHMbj3bO
         bKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUybqQz2J5D+P4tZdb22yXHjHOS7bGmeyii5MJ0L5og32iFwVXdibjE6xOJBODt3enTziXBGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxluZZtf1dhmzlqynRDSmRNfHSG7CqtRLGALw7D9r+Ls9DH7QeD
	agGgleMQnBXuhx5AjrfoU0Ar+2SSkAcL92h4J680RtbcJVwKgBS66l2YVPdZWxac02w=
X-Gm-Gg: ASbGncsPaWONkFB6vgycWb5qaW1dSh5Ha6MQzHg7n2mqOeCBKX7/oJhFKJdzcSUS2WV
	1siXtpaCHxobdm1HZ8y3sBuC3xFf1XNbnrKLXRh1XI7RoTzUp9b96eviOZqopx8Fq+zmyEZyepD
	dTZ0exBopPE/xDIqRuqqKZgtyqxtlT+kjyi38INZcXnBbACuLf9KlHZbRxOEo4nDYDg88EFhvfk
	1DoeMtrBoM901qNaowBHRYUpYXXwuWBh64tvKp8ClrLrDqTWN159Pe7Tf1U6P+RbOkk5xc4iH53
	3Ld9c0Lb4NmuU2pf02af89UtzmmnzcHBT47I4b8VKp1or7cAi4Xybk2SwwYeWSyva04pFVvV6Ro
	7tqh60TAICfRZ/3lYpI8fqZc/OZbsT7OMwbiBDcpIUhVE1W0vCAh5ImLzpteJdLaca83COUcCq4
	5MpmTx7ylrANIyuMynGECNQ4ftp2Wk7nXVlXx0yrHHDGxhLQ==
X-Google-Smtp-Source: AGHT+IFaewYCh7lZ/e3jrLC+zJ6aPttGSWBIKbLkQBuHB0fmqLtXdWY7nE/Y+kB9ksn8kefKsppo3A==
X-Received: by 2002:ad4:5aa7:0:b0:880:5cc1:6923 with SMTP id 6a1803df08f44-880711d8255mr64437896d6.36.1762366610614;
        Wed, 05 Nov 2025 10:16:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c457bsm1883826d6.5.2025.11.05.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:16:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGi3s-00000007CLf-2PE0;
	Wed, 05 Nov 2025 14:16:48 -0400
Date: Wed, 5 Nov 2025 14:16:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Gregory Price <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <20251105181648.GR1204670@ziepe.ca>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQtiUPwhY5brDrna@gourry-fedora-PF4VCD3F>
 <20251105172115.GQ1204670@ziepe.ca>
 <03e363c3-638a-4017-99c2-b6668ca8d25a@lucifer.local>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e363c3-638a-4017-99c2-b6668ca8d25a@lucifer.local>

On Wed, Nov 05, 2025 at 05:32:29PM +0000, Lorenzo Stoakes wrote:

> Obviously heavily influenced by your great feedback, but I really did try to
> build it in a way that tried to simplify as much as possible.

My main remark, and it is not something you should necessarily do
anything about, but pte_none() can be given a consistent name too:

leafent_is_none_pte(pte)

Which is definted to be identical to:

leafent_is_none(leafent_from_pte(pte))

But presumably faster.

Jason
