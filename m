Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB20303CA4
	for <damon@lists.linux.dev>; Fri, 21 Nov 2025 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763768700; cv=none; b=itir58ZakrNGpEoPwYw2FqPT/drQB1c16A6lzM274hcpQtOHeqzCktFYz/b/KeU1fawyWBHApbFDANKvsIw3VLmd5TXY8mwHfSf7DYEfr2pmqH+d9iC1dfu0OUyWE/6j1hCxd6kQA/1NHguKmkwD7L0F5/c7fyCt09L2sd1KDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763768700; c=relaxed/simple;
	bh=94wkD2Iff42VLMlQNWegA9dtRPkkPQ7m6y0iMS1EKU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVmwGWbh/zepG1RKa/GMbNI4DXPMMANdGjK9ys9wZLxxfqFnyZ1ujYJgyD01RjzeztGTTHYFXSBewj1Q2AZ3Fp1d5kKJfYdph64RveoyoKFmUBNXVo7sdf2slMF7sa2rdWyLik9vzCmzCdd4uPjNJE9BLh5YZtj4YXc438aslDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eneBQ3we; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eneBQ3we"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8823cde292eso26285246d6.2
        for <damon@lists.linux.dev>; Fri, 21 Nov 2025 15:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763768697; x=1764373497; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94wkD2Iff42VLMlQNWegA9dtRPkkPQ7m6y0iMS1EKU4=;
        b=eneBQ3weM+m/dYIly7XoPGsZbxMmJDgWAAnIwqjxX4Ln0AzXRrrAsdwytcQJAvJZmR
         47qL96g+e89tp5fRIMmxOuli9Lk0GWlXB+gKcYOrsJeZQ0Nq9d/MmKJaRbIVsFL6LTIn
         2Teqp1vB0Vhnb8rdbpdPfVfHINVvxcWd+d7qbCaOVsSzwjpEQxyZgE7W4XaFfySw45Wz
         qF4Qh18ke1l5TIj4/Zg2WhHp364fVPHYGBEAGNkIhn5mP6M+OWFxC4gNP05DWyZgZiZc
         nTqlHI+hKwKnuBGHRPzhLlJDtDqPLfYQT/m10VvVAugv/ZNoyXLEX0UG0hL90JnKMjyh
         zCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763768697; x=1764373497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94wkD2Iff42VLMlQNWegA9dtRPkkPQ7m6y0iMS1EKU4=;
        b=s1GgBtXQeKFSBP0fBz+huMSFYGkB1WLvoAIiQWfwoj1sIa7rdTErXQTPE0krcBhrM1
         u0r9rrhxEMuSdH10SQ6cpJFBxH36NQDeJGROWd6LPsRv5ZPdMnQzfb6S1ONe/vZ3p0Tf
         5bOeCYKVR/iKHtVVdLfTQtSvqH+FhJeXVA/G9fjNKbk5kcp2clOjFVsNNB4ovGZM5t2G
         YDMIVl723VJcKaENBzRt2jl/RQ7g7PvGTEs6u+w6ZJgf0GUpwewq2DVSzASHQGg5CogU
         9VqZjgKSlLs347BB3eyk4WzUVyQBL2ydAELlOJpGwWQZL6oYe3K+RX6/IpOvHWjqYsgH
         NGRg==
X-Forwarded-Encrypted: i=1; AJvYcCX3XfU8ZTI6njFSZBeAdLY/PqbWtqkokbAT6zVfeHAC3MO5gdIh+ZuQvYusNn3nTqxIubaPkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF2P0n2Gb4U43X0AzrDqcAF35BETBDY8anOB+7uaYL87do0jcA
	/Wnqr2ajmHFMy02koBqdYJ/xOdmPSkhdAVOaoHKfmYCk4Z7suzLaQ1UUDIZXW+ePyBE=
X-Gm-Gg: ASbGncsxhxOi0kPi/FjVqW/KiqwKYJtbwam9k66REERkFa/G1oLLEcgQRCyJUPVjY79
	UeqqsqvkZvpyl6ncfUv79lMfTCJyd8Sb4XosDuIKf093sEyfxqekEiWU4uZBgS9ccF64jCkKNYx
	J4r89zcqXI6p1iI4T9z5nhfEZgCmpUgN27kc3Jo5rhWXWhzzbgE6YqIAltASp2eEBAPA0CAsCKt
	glsuQITn1bSKgOLcpadxoeIV49ZVVxm7Gva/TjNsKPk59MASH1obIU8vRqdq1pjiaygZcqrYlNd
	DUB2LAE44g61Aru6ZQvx1/UYDcmrg3Yyv/gHI4Oc00rtzKJeuxPu+cLkaYJH4mJCI9BXc2X8cts
	9Tc7Cg31eVC5ahRQCrXQw6+al4j7i2XiSbwUN6YBUJwZQ9iLqwx+V9/FYN1hjWcPoHHsxl5wNx+
	zsjzqOl6vjZYmKtp5aGXbBnbws7pWUnDrj+/oSBDnVl7Uv9sZzrzgG5S0Q
X-Google-Smtp-Source: AGHT+IEos7T2Axz389Mmy3AFU8+Jfh3PFehz2HfOxc6qgzO/Its691H7QS0uM/0VDIYstKPPxEQUqg==
X-Received: by 2002:a05:6214:226c:b0:87d:fc3e:6d9b with SMTP id 6a1803df08f44-8847c525de0mr61714186d6.42.1763768697300;
        Fri, 21 Nov 2025 15:44:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54c32csm48350666d6.37.2025.11.21.15.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:44:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMaoC-00000001bmD-0arX;
	Fri, 21 Nov 2025 19:44:56 -0400
Date: Fri, 21 Nov 2025 19:44:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Gregory Price <gourry@gourry.net>,
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
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-ID: <20251121234456.GA383361@ziepe.ca>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>

On Mon, Nov 10, 2025 at 10:21:18PM +0000, Lorenzo Stoakes wrote:
> There's an established convention in the kernel that we treat leaf page
> tables (so far at the PTE, PMD level) as containing 'swap entries' should
> they be neither empty (i.e. p**_none() evaluating true) nor present
> (i.e. p**_present() evaluating true).

I browsed through this series and want to give some encourgement that
this looks nice and is a big step forward! Lots of details to check
the conversions so I wouldn't give any tags due to lack of time..

Jason
