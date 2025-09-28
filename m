Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216433EC
	for <damon@lists.linux.dev>; Sun, 28 Sep 2025 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759022986; cv=none; b=N4bD42f+SpXTXudqxEZBtYJ9sulHurT9HXyQ/0t1gu9Nm2XipUqzh2y0pptDFvvFL755/d1b6TQTJFPPmUHGrXmmfxta0jARHHByD08SL6HfpDEPleTTweeej/nPl8qOfCE0NQqnAcsSDOpHh8PyZ8IcPliC6QEcqZd2yrJ/+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759022986; c=relaxed/simple;
	bh=tYaAYB06afOao3vif5FoPI8ItokVqPkESNwatJyJG4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuhLyZWTZ+Oz0YtJlN3XEl3GEOT/ZvuMuh14mBZgfEjRAgb2TnCSx7QkUqaejdqacOrdSnXeWL4eJ0aWGLTt8lertBTTIJuNvq4EvJjYpDRlumfi1D85kh+3bvul9C+R+bDny1FHG/OdhpWvPaz/ZYKH8HguhPULjWVmKV2bTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO8yG60P; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO8yG60P"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso6597187a12.0
        for <damon@lists.linux.dev>; Sat, 27 Sep 2025 18:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759022984; x=1759627784; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaaA7VF/d1dd6Y2aehhgBQqzOxirTeBTgDR7whafJPs=;
        b=FO8yG60PqassF0o/CboFaybufqJxItra8I/4Byxk+ss2yPGKHeV++e57AcjHhhbsvG
         zjcKqgQ+/yWhedx2xzgu+FiEBRJD7hKOEZO43m8SOKe9qJ7e2WFIfZYt8s8SlJSQ9/2g
         gtkmhR9UjtGvWchIoLAvBJnfygCljNi+f5h6HE8QSCJIXFo4oEtElxIkkcybxhNvuXFS
         rMSwvwxhzoHT8LGzkyxWQoZ6LTjTR9Od9uEOH9lMtSEUN4XaPOCpOP9smtt2dWetm/kD
         HCap444zk8j/07HxNBYd1+wGqEx/KwHS7lV5o0NUX3G6mGEQ3IMAc1Ice0yzzWX/G+qB
         yPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759022984; x=1759627784;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qaaA7VF/d1dd6Y2aehhgBQqzOxirTeBTgDR7whafJPs=;
        b=BTjVkIxfArKIlB4/UV5PGVY+RnIGR1G9wK3M2r7vJFtriKDHLfEYN+naubG9u/kazF
         PLqlafoSXB44/C71oyN2Nkqglrm+udanIvCk2bQAP9hFxm/L3H62TGijfAnB/97GvUGn
         a4FVoq5H57IwxBaOA9QgsMms68Cxe4sQlW+NcF1+5lRez0GBi393vGXRSJ9Yof3jaH5g
         R6r7y6xMevpHXgFseo6WsX7FNvJ6hrKk4w0pRvPzam8X75AF5m32Ag7jLI22arz134eT
         9LuQMBCjpl8/4wqNj31+UiyReKOTFLwMEC59GRPtL23ep8zH3d26J/Rxe0hI8/VyWrCI
         NmCA==
X-Forwarded-Encrypted: i=1; AJvYcCVUBKmu6AuVpTH3jrNb8Lz6c2SGaVSqIhIGV4lwArh/w9YnHnZlZuuLg5RNQCyb8awBX02rjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDBh8p0hO09SYzjNb65zxFFDQakWaUqqmeubVczSzTpiF8Bwom
	SOho2PKl3AFWhBhdOXrf1DMO+rDTLkej4sqIW8BwopJESu5ZiMzhiryi
X-Gm-Gg: ASbGncso62M3BRlcenmzHHam2dn1s1S5O+Ofh8d5reqe1W/pBV461mmEy2ny5NDXvqq
	vilCYfYk0dRKpRRPPWPv9AQagQ9MorzSJfmTFx9gFWNmye2De5hRFmPsUPy4rqRq17Q+Qw6xvDd
	tEgQQ6GRLRB7+BZHlS/c1hJ/h936PNQmVycbvDiU/S/E5j6yjYW4MGDKIzAHAyLK8r4s7Nj/cWY
	Xe6lLUh3fNJuk5ABWXDtcEVT6vc6Jt6c5UERBL8zGxds0GM9pPghCHiogkRrTH+/pvKxMvGYgaC
	w8XD0Yx68tNUjaxw6vD5OGDWnN8Fln5X9vGN6ZNIgfXOJHf0ETmXID+ispfcMrlmAjPM2SPVfyD
	J5F73ipwpYe3bg6rIMQFL4mvuWw==
X-Google-Smtp-Source: AGHT+IH8PMCyGq17Grbmlu3IHSZf8Q6pFvykXtFEHcjxN4vNb3KgLD91h4nEUAxKcQcxVpCFfsUfRw==
X-Received: by 2002:a05:6402:44c3:b0:62f:ce89:606f with SMTP id 4fb4d7f45d1cf-6349f9ef17cmr9469195a12.12.1759022983448;
        Sat, 27 Sep 2025 18:29:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634bf4a5351sm3206980a12.43.2025.09.27.18.29.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Sep 2025 18:29:42 -0700 (PDT)
Date: Sun, 28 Sep 2025 01:29:41 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "jianyun.gao" <jianyungao89@gmail.com>
Cc: linux-mm@kvack.org, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"open list:DATA ACCESS MONITOR" <damon@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KMSAN" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] mm: Fix some typos in mm module
Message-ID: <20250928012941.wildyant57igw7zi@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250927080635.1502997-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927080635.1502997-1-jianyungao89@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Sep 27, 2025 at 04:06:34PM +0800, jianyun.gao wrote:
>Below are some typos in the code comments:
>
>  intevals ==> intervals
>  addesses ==> addresses
>  unavaliable ==> unavailable
>  facor ==> factor
>  droping ==> dropping
>  exlusive ==> exclusive
>  decription ==> description
>  confict ==> conflict
>  desriptions ==> descriptions
>  otherwize ==> otherwise
>  vlaue ==> value
>  cheching ==> checking
>  exisitng ==> existing
>  modifed ==> modified
>
>Just fix it.
>
>Signed-off-by: jianyun.gao <jianyungao89@gmail.com>

LGTM, thanks.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
